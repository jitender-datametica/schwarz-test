CREATE TABLE IF NOT EXISTS ldl_s_conl_workbench.t_i_cost_sap (
cost_typ STRING(20) COLLATE 'und:ci',
cost_typ_desc STRING(50) COLLATE 'und:ci',
cost_center STRING(20) COLLATE 'und:ci',
object_desc STRING(20) COLLATE 'und:ci',
booking_year STRING(5) COLLATE 'und:ci',
booking_periode STRING(4) COLLATE 'und:ci',
saldo_amount NUMERIC(20,5),
contra_account_desc STRING(100),
transcation_desc STRING(100) COLLATE 'und:ci'
);