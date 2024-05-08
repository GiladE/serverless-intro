.SILENT: prepare-venv

prepare-venv: ## Install venv and install deps
	if [ ! -d ./venv ]; then echo "==   Creating new venv (./venv)" && python3 -m venv ./venv; fi
	./venv/bin/python -m pip install --upgrade pip
	echo '==   Install requirements.txt' && ./venv/bin/python -m pip install -r requirements.txt
	./venv/bin/python -m pip install awscli
	npm install -g serverless serverless-offline serverless-python-requirements
