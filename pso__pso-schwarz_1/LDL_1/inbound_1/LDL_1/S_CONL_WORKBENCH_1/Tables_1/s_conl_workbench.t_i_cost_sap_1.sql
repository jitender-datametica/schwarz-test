CREATE TABLE s_conl_workbench.t_i_cost_sap_1
(
cost_typ VARCHAR(20) COLLATE 'en-ci',
cost_typ_desc VARCHAR(50) COLLATE 'en-ci',
cost_center VARCHAR(20) COLLATE 'en-ci',
object_desc VARCHAR(20) COLLATE 'en-ci',
booking_year VARCHAR(5) COLLATE 'en-ci',
booking_periode VARCHAR(4) COLLATE 'en-ci',
saldo_amount DECIMAL(20,5),
contra_account_desc VARCHAR(100) /*** MSC-WARNING - MSCEWI2040 - FORMAT 'X(20)' NOT SUPPORTED ***/,
transcation_desc VARCHAR(100) COLLATE 'en-ci');


