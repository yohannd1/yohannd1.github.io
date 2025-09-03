# This makefile is just for testing locally, as github already deploys automaticaly through the action in .github/workflows.

BUILD_DIR := build

run:
	if [ -d $(BUILD_DIR) ]; then rm -r $(BUILD_DIR); fi
	janet src/main.janet $(BUILD_DIR)
