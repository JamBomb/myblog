.PHONY: build serve stop restart clean deploy

PORT = 8080
SITE = site
DEPLOY_DIR = /var/www/cosmoart

build:
	@mkdocs build

serve:
	@cd $(SITE) && python3 -m http.server $(PORT)

stop:
	@PID=$$(lsof -ti:$(PORT)); \
	if [ -n "$$PID" ]; then \
		kill $$PID; \
		echo "Server stopped (PID=$$PID)."; \
	else \
		echo "No process is using port $(PORT)."; \
	fi

restart: stop build
	@cd $(SITE) && nohup python3 -m http.server $(PORT) >/tmp/cosmoart.log 2>&1 &
	@echo "Preview: http://localhost:$(PORT)"

clean:
	@rm -rf $(SITE)

deploy: build
	@sudo mkdir -p $(DEPLOY_DIR)
	@sudo rsync -a --delete $(SITE)/ $(DEPLOY_DIR)/
	@sudo echo "Deploy completed."
	@sudo tree $(DEPLOY_DIR)
