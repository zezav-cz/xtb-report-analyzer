# How to Use the Application

This guide will walk you through the steps to set up and use the application, including creating and migrating the database, converting an XLSX file to JSON, importing the JSON data into the database, and running the UI.

## Prerequisites

- Ruby installed on your system
- SQLite3 installed on your system
- Bundler installed (`gem install bundler`)
- task installed (`https://taskfile.dev/`)

## Step 1: Set Up the Project

1. **Clone the repository:**

   ```sh
   git clone <repository_url>
   cd xtb-report-analyzer
   ```

2. **Install dependencies:**

    ```sh
    bundle install
    ```

## Step 2: Create and Migrate the Database

1. **Create the database:**

    ```sh
    task create_db
    ```

2. **MigrateDB:**

    ```sh
    task run_migrations
    ```

## Step 3: Convert XLSX to JSON
2. **Run the converter:**

    ```sh
    bundle exec bin/xtb_report_analyzer convertor dev/repo.xlsx | jq | tee dev/repo.xlsx.json
    ```

## Step 4: Import JSON Data into the Database

1. **Import the JSON data:**

    ```sh
    bundle exec ruby bin/xtb_report_analyzer import -f dev/repo.xlsx.json
    ```

## Step 5: Run the UI

1. **Run the UI:**

    ```sh
    bundle exec ruby bin/ui.rb dev/sqlite3.db
    ```
