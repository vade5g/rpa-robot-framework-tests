import json

from robot.libraries.BuiltIn import BuiltIn

output_file = BuiltIn().get_variable_value("${output_json_file}")


class JSONLibrary:

    def __init__(self):
        self.data = BuiltIn().get_variable_value("${DATA}")

    def save_json_file_to_disk(self):
        with open(output_file, "w") as f:
            json.dump(self.data, f, indent=4)
