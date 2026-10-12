CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_lago_supplier_1
(
   client_id
  ,country_iso_cd
  ,orig_supplier_nr
  ,supplier_id
  ,cs_updated
  ,cs_created
  ,cs_load_id
)
AS
SELECT
   client_id
  ,country_iso_cd
  ,orig_supplier_nr
  ,supplier_id
  ,cs_updated
  ,cs_created
  ,cs_load_id
FROM P_LEW_MART_CS.v_lago_supplier_1;