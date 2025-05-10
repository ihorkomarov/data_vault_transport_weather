from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    'owner': 'airflow',
}

with DAG(
    dag_id='dbt_run_dag',
    default_args=default_args,
    description='Run dbt models',
    schedule_interval=None,
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["dbt", "data_vault"],
) as dag:

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd /opt/airflow/dbt && dbt run'
    )
