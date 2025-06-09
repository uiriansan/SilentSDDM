#!/bin/python3

######################################################################################################
#                                                                                                    #
#                               DO NOT CHANGE THE INDENTATION IN THIS FILE!                          #
#                                                                                                    #
######################################################################################################

import json, re

CONFIG_FILE = "../components/Config.qml"
JSON_FILE = "options.json"
MD_FILE = "options.md"

def parse_config():
    with open(CONFIG_FILE, "r") as file:
        json_output = {}

        for line in file:
            line = line.strip()
            if line.startswith("property"):
                spaced_line = line.split(" ")
                type = spaced_line[1]
                property = spaced_line[2].replace(":", "")
                quoted_line = re.findall('["|\'](.+?)["|\']', line)[0]
                split_quoted_line = quoted_line.split("/")
                category = split_quoted_line[0] if "/" in quoted_line else "General"
                option = split_quoted_line[1] if "/" in quoted_line else split_quoted_line[0]
                default = ""
                if "@default:" in line:
                    default = line.split("@default:")[1].split("@")[0].strip()
                elif "||" in line:
                    default = line.split("||")[1].strip().replace('"', "").split("//")[0].strip()
                elif type == "bool" and "config[" in line:
                    default = "true"
                elif type == "bool":
                    default = "false"
                elif type == "int":
                    default = "0"
                elif type == "real":
                    default = "0.0"
                possible = ""
                if "@possible:" in line:
                    possible = line.split("@possible:")[1].split("@")[0].strip()
                elif type == "color":
                    possible = "QColor"
                elif type == "bool":
                    possible = "'true' | 'false'"
                elif type == "string" and "clock" in property.lower() and "format" in property.lower():
                    possible = "QTime"
                elif type == "string" and "date" in property.lower() and "format" in property.lower():
                    possible = "QDate"
                desc = line.split("@desc:")[1].split("@")[0].strip() if "@desc:" in line else ""

                if category not in json_output:
                    json_output[category] = []
                json_output[category].append({
                    "category": category,
                    "option": option,
                    "type": type,
                    "default": default,
                    "possible": possible,
                    "desc": desc,
                    "property": property
                })

        return json_output


def generate_json_file(json_output):
    jsonf = json.dumps(json_output)
    with open(JSON_FILE, "w") as file:
        file.write(jsonf)
        print(f"Generated `{JSON_FILE}`")

def generate_md_file(json_output):
    table = ['<table><tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr>']
    ref = ["\n-- --"]

    for i, (category, options) in enumerate(json_output.items()):
        # category title
        ref.append(f'\n## [{category}]')

        for j, option in enumerate(options):
            # TABLE
            table.append("<tr>")
            if j == 0:
                table.append(f'<td rowspan="{len(options)}" align="right"><a href="#{category.lower().replace(".", "")}">[{category}]</a></td>')

            formated_possible = ""
            if option["possible"] == "QColor":
                formated_possible = '<a href="https://doc.qt.io/qt-6/qml-color.html#details">QColor</a>'
            elif option["possible"] == "QTime":
                formated_possible = '<a href="https://doc.qt.io/qt-6/qtime.html#toString">QTime format string</a>'
            elif option["possible"] == "QDate":
                formated_possible = '<a href="https://doc.qt.io/qt-6/qdate.html#toString">QDate format string</a>'
            else:
                formated_possible = option["possible"]
            table.append(f'''<td align="left">
<a href="#{option["property"].lower()}">{option["option"]}</a>
</td>
<td align="center">{option["type"]}</td>
<td align="center">{option["default"]}</td>
<td align="left">

{formated_possible.replace("'", "`").replace("|", " ").strip()}

</td>''')
            table.append("</tr>")

            # REFERENCE
            # option reference:
            ref.append(f'''<details name="{option["property"].lower()}">
<summary><strong>{option["option"]}</strong></summary><br/>
<p>{option["desc"]}</p></br></br>
<table>
<tr>
<td>Type</td></br>
<td>{option["type"]}</td>
</tr>
<tr>
<td>Default value</td>
<td>{option["default"]}</td>
</tr>
<tr>
<td>Possible values</td>
<td>

{formated_possible.replace("'", "`").replace("|", " ").strip()}

</td>
</tr>
</table>
</details>''')

        if i != len(json_output) - 1:
            table.append('<tr><td colspan="5">&nbsp;</td></tr>')
            table.append('<tr><th align="right">Category</th><th align="left">Option</th><th>Type</th><th>Default value</th><th align="left">Possible values</th></tr>')

        ref.append('\n-- --')

    table.append('</table>\n')

    with open(MD_FILE, "w") as file:
        file.write("".join(table) + "\n".join(ref))
        print(f"Generated `{MD_FILE}`")

if __name__ == "__main__":
    json_output = parse_config()
    generate_json_file(json_output)
    generate_md_file(json_output)
