"""
Read csv file to a list of dictionaries and print to console.
"""
import csv


class CSVReader:

    def read_csv_file(self, filename):
        with open(filename, "r") as csv_file:
            reader = csv.reader(csv_file, skipinitialspace=True, delimiter=";")
            raw_data = list(reader)
            header = raw_data.pop(0)
            data = [{value: row[i] for i, value in enumerate(header)} for row in raw_data]

            print(data)
            return data
