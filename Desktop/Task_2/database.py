from flask import Flask, request, jsonify
import mysql.connector


app = Flask(__name__)

# MySQL Configuration
mysql_config = {
    'host': 'URL of the RDS instance in AWS',
    'database': 'visitors',
    'user': 'admin',
    'password': 'admin123',

}

# Function to establish MySQL connection
def connect_to_mysql():
    connection = mysql.connector.connect(**mysql_config)
    if connection.is_connected():
        print('Connected to MySQL database')
        return connection


# POST endpoint to add a visitor's name to the table
@app.route('/visitor', methods=['POST'])
def add_visitor():
    connection = connect_to_mysql()
    if connection:
        cursor = connection.cursor()
        name = request.json['name']
        insert_query = "INSERT INTO visitors (name) VALUES (%s)"
        cursor.execute(insert_query, (name,))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({'message': 'Visitor added successfully'}), 201
    else:
        return jsonify({'error': 'Database connection error'}), 500


# GET endpoint to retrieve a list of all visitors
@app.route('/visitors', methods=['GET'])
def get_visitors():
    connection = connect_to_mysql()
    if connection:
        cursor = connection.cursor()
        query = "SELECT id, name, visit_time FROM visitors"
        cursor.execute(query)
        records = cursor.fetchall()
        cursor.close()
        connection.close()
        visitors_list = []
        for row in records:
            visitor = {
                'id': row[0],
                'name': row[1],
                'visit_time': row[2].strftime('%Y-%m-%d %H:%M:%S')
            }
            visitors_list.append(visitor)
        return jsonify({'visitors': visitors_list})
    else:
        return jsonify({'error': 'Database connection error'}), 500


if __name__ == '__main__':
    app.run(debug=True)