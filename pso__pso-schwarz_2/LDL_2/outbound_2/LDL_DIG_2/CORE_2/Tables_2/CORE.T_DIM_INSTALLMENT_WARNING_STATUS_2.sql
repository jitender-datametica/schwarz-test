CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_installment_warning_status_2 (
install_warn_status_cd BIGNUMERIC NOT NULL
OPTIONS(description='If an order position was not paid, warning status_2 occurs. A warning status_2 cannot decrease. The warning status_2 increases as long as the payment is due'),
install_warn_status_descr STRING(250) NOT NULL OPTIONS(description='The textual description for the warning status_2'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (install_warn_status_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the warning levels that are set if customer does not pay the instalment');