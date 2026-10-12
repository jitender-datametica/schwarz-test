CREATE OR REPLACE TABLE szd_production_core.t_fact_rvm_cleaning_2 (
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
begin_of_cleaning_dt DATE NOT NULL OPTIONS(description='The date when the deposit machine was cleaned.'),
begin_of_cleaning_tm TIME NOT NULL
OPTIONS(description='The time when preventive maintenance was carried out on the deposit machine.'),
cleaning_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning type'),
cleaning_status_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning status_2'),
end_of_cleaning_dt DATE NOT NULL OPTIONS(description='The timestamp for the end of cleaning of the deposit machine'),
end_of_cleaning_tm TIME NOT NULL OPTIONS(description='The time for the end of cleaning of the deposit machine'),
cleaning_dur_sec_cnt INTEGER NOT NULL OPTIONS(description='The analytical fact for the cleaning duration time'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sid, begin_of_cleaning_dt, begin_of_cleaning_tm) NOT ENFORCED
) OPTIONS(description='Transactional facts capturing the cleaning operations of deposit machines.');