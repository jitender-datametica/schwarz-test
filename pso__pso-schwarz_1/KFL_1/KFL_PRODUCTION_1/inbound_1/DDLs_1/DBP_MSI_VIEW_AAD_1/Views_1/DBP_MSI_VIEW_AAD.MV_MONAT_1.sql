CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_MONAT_1 AS
--14.06.2023 twie: SPEC0200542 Lookup Monat_1
   SELECT
    gjmo
  , gjmo_vj
  , mo_gj
  , kjmo
  , kjmo_vj
  , mo_kj
  , akt_mo
  , akt_mo_komplett
  , gjqu
  , akt_gjqu
  , akt_gjqu_komplett
  , kjqu
  , akt_kjqu
  , akt_kjqu_komplett
  , gj
  , akt_gj
  , akt_gj_komplett
  , kj
  , akt_kj
  , akt_kj_komplett
  , YEAR(ADD_MONTHS(CAST(LEFT((kjmo)::VARCHAR(10),4) || '-' || RIGHT((kjmo)::VARCHAR(10),2) || '-20' AS DATE),-1))::VARCHAR(10)
   || MONTH(ADD_MONTHS(CAST(LEFT((kjmo)::VARCHAR(10),4) || '-' || RIGHT((kjmo)::VARCHAR(10),2) || '-20' AS DATE),-1))::VARCHAR(10)::INT AS KJMO_VM
  , (kj-EXTRACT(YEAR FROM CURRENT_DATE))*12+(MOD(kjmo, 100))-EXTRACT(MONTH FROM CURRENT_DATE) AS AKT_MO_KALENDARISCH
FROM dbp_view.v_monat_1

WHERE kjmo>=202301;