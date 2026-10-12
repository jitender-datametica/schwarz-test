CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_supplier_mdm_link_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key of the ERP client of the supplier_2 related to the NFPO supplier_2'),
sup_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='foreign key of the ERP based supplier_2 related to the NFPO supplier_2'),
mdm_sup_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='foreign key NFPO supplier_2            CBX: CNT_VENDOR.REF_NO'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (sup_sid, mdm_sup_sid) NOT ENFORCED
) OPTIONS(description='Supplier_2 master link; based on EKS supplier_2 number');