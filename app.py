from flask import Flask, request, jsonify
from aqua import CF_Solver

app = Flask(__name__)


@app.route('/cookies', methods=['GET'])
def get_cookies():
    url = request.args.get('url')
    if not url:
        return jsonify({"error": "Missing 'url' parameter"}), 400

    user_agent = request.headers.get('User-Agent')
    if not user_agent:
        return jsonify({"error": "Missing 'User-Agent' header"}), 400

    try:
        cf_solver = CF_Solver(
            url,
            userAgent=user_agent,
        )
        cookie = cf_solver.cookie()

        return jsonify({"cookies": cookie})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000)
