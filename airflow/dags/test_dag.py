from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime

# Funktion, die ausgeführt wird
def hello_world():
    print("Hello, this is your first Airflow DAG!")

# DAG definieren
with DAG(
    dag_id="simple_test_dag",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,  # Kein automatischer Zeitplan
    catchup=False,
    tags=["demo"],
) as dag:

    task_hello = PythonOperator(
        task_id="print_hello",
        python_callable=hello_world
    )
