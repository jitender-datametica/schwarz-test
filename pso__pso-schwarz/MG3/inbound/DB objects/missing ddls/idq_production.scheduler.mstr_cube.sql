CREATE OR REPLACE TABLE idq_production.scheduler.mstr_cube (
    id NUMBER(38,0) NOT NULL AUTOINCREMENT START 1 INCREMENT 1 ORDER,
    mstr_cube_id VARCHAR(250),
    mstr_project_id VARCHAR(250),
    mstr_cube_name VARCHAR(250),
    source_system_type_id NUMBER(3,0)
);