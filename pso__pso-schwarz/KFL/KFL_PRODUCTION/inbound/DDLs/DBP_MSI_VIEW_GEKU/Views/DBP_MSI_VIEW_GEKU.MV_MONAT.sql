CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_MONAT
(
gjmo
,gjmo_vj
,mo_gj
,kjmo
,kjmo_vj
,mo_kj
,akt_mo
,akt_mo_komplett
,gjqu
,akt_gjqu
,akt_gjqu_komplett
,kjqu
,akt_kjqu
,akt_kjqu_komplett
,gj
,akt_gj
,akt_gj_komplett
,kj
,akt_kj
,akt_kj_komplett
,kjmo_vm
,akt_mo_kalendarisch
)
AS
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
  -- , TRUNC(ADD_MONTHS(CAST(kjmo*100-19000000+1 AS DATE),-1)/100) + 190000
  , YEAR(ADD_MONTHS(CAST(LEFT((kjmo)::VARCHAR(10),4) || '-' || RIGHT((kjmo)::VARCHAR(10),2) || '-20' AS DATE),-1))::VARCHAR(10)
   || MONTH(ADD_MONTHS(CAST(LEFT((kjmo)::VARCHAR(10),4) || '-' || RIGHT((kjmo)::VARCHAR(10),2) || '-20' AS DATE),-1))::VARCHAR(10)::INT
  , (kj-EXTRACT(YEAR FROM CURRENT_DATE))*12+(MOD(kjmo, 100))-EXTRACT(MONTH FROM CURRENT_DATE)
   FROM dbp_view.v_monat
   WHERE kjmo>=200201;