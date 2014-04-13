SRC_DIR = src
DOC_DIR = docs
PROJECT_DIR = pyhn
MAKE = make
export SECRET_KEY='dev'

all:
	make lint
	make test
	make html
	make clean

lint:
	pylint --rcfile=.pylintrc --load-plugins pylint_django -E $(SRC_DIR)/$(PROJECT_DIR)

lintall:
	pylint --rcfile=.pylintrc --load-plugins pylint_django $(SRC_DIR)/$(PROJECT_DIR)

test:
	python $(SRC_DIR)/manage.py test --failfast --nocapture --with-coverage --cover-package=$(PROJECT_DIR) --settings=pyhn.settings.test

html:
	cd $(DOC_DIR) && $(MAKE) html

clean:
	rm -rf *.egg-info
	rm -rf build/*
	rm -rf dist/*
	rm -rf src/*.egg-info
	find $(SRC_DIR) -name "*.pyc" | xargs rm

run:
	cd $(SRC_DIR) && python manage.py runserver 0.0.0.0:$(PORT) --settings=pyhn.settings.dev
