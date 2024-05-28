from flask import Flask, request, jsonify
import subprocess
import pandas as pd
from io import StringIO

app = Flask(__name__)

@app.route('/tables', methods=['GET'])
def get_tables():
    database = request.args.get('database')
    if not database:
        return jsonify({'error': 'database parameters are required'}), 400
    try:
        output = subprocess.check_output(['mdb-tables', '-1', database])
        tables = output.decode().splitlines()
        return jsonify(tables)
    except subprocess.CalledProcessError as e:
        error_output = e.output
        return jsonify({'error': error_output}), 500


@app.route('/export', methods=['GET'])
def export_table():
    database = request.args.get('database')
    table = request.args.get('table')

    if not database or not table:
        return jsonify({'error': 'Both database and table parameters are required'}), 400

    try:
        output = subprocess.check_output(['mdb-export', database, table, '-d ;'], universal_newlines=True)     
        csv_data = StringIO(output)
        df = pd.read_csv(csv_data, delimiter=';')
        return df.to_json(orient='split')
    except subprocess.CalledProcessError as e:
        error_output = e.output
        return jsonify({'error': error_output}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)