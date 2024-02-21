# This makefile is just for testing locally, as github already deploys automaticaly through the action in .github/workflows.

BUILD_DIR := build

run:
	rm -r $(BUILD_DIR)
	janet src/main.janet $(BUILD_DIR)
