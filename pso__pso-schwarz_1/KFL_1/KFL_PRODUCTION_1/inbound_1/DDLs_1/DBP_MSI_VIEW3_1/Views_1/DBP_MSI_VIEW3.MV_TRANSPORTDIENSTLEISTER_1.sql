CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTDIENSTLEISTER_1
(
mandant_id
,belos_adresse_spedition_id
,tdl_name_belos
,tdl_name_wanko
,belos_fg
,wanko_fg
,adress_name
,land_id
,adress_name_zusatz
,strasse
,be_entlade_stelle
,plz
,ansprechpartner
,ort
)
AS
--2025-02-26, nwag, adding WANKO
 SELECT
 mandant_id,
 belos_adresse_spedition_id,
 MAX(CASE WHEN tdl_src = 'BELOS' THEN adress_name END) AS tdl_name_belos,
 MAX(CASE WHEN tdl_src = 'WANKO' THEN adress_name END) AS tdl_name_wanko,
 MAX(CASE WHEN tdl_src = 'BELOS' THEN 1 ELSE 0 END) AS belos_fg,
 MAX(CASE WHEN tdl_src = 'WANKO' THEN 1 ELSE 0 END) AS wanko_fg,
 COALESCE(tdl_name_wanko,tdl_name_belos) AS adress_name,
 MAX(land_id),
 MAX(adress_name_zusatz),
 MAX(strasse),
 MAX(be_entlade_stelle),
 MAX(plz),
 MAX(ansprechpartner),
 MAX(ort)
 FROM (
SELECT
   'BELOS' AS tdl_src,mandant_id, belos_adresse_id  AS belos_adresse_spedition_id, land_id, adress_name, adress_name_zusatz, strasse, be_entlade_stelle, plz, ansprechpartner, ort
    FROM dbp_view.v_belos_adresse_1
   WHERE
   -- nur Transportdienstleister (Adressen)
   spedition_fg = 1
   UNION ALL
   -- 2020-02-06 [nw] Dummies - AP0055243 / SPEC0070514
   SELECT
   'BELOS' AS tdl_src,mandant_id, ''  AS belos_adresse_spedition_id, '' AS  land_id, 'nicht definiert / not defined' AS adress_name, '' AS adress_name_zusatz, '' AS strasse, '' AS be_entlade_stelle, '' AS plz, '' AS ansprechpartner, '' AS ort
   FROM dbp_view.v_mandant_1
UNION
   SELECT 
   'WANKO' AS tdl_src, gp.mandant_id, gp.tms_gp_id AS belos_adresse_id, TMS_LAND_CD  AS land_id, gp.tms_gp_name AS adress_name, gp.TMS_GP_ALTNV_NAME  AS adress_name_zusatz, gp.TMS_GP_STRASSE AS strasse, '' AS be_entlade_stelle, gp.TMS_GP_PLZ AS plz, '' AS ansprechpartner, gp.TMS_GP_ORT_NAME AS ort
   FROM dbp_data.tms_gp_1 gp_1
   JOIN dbp_view.v_l_system_1 s
   ON gp.system_id = s.system_id
   WHERE gp.tms_gp_typ_cd= 'S'
   --retain records from KTMS_DE if same id is used in KTMS_FLW_DE
   QUALIFY ROW_NUMBER() OVER (PARTITION BY gp.mandant_id, gp.tms_gp_id ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1
   ) v00
    GROUP BY  mandant_id, belos_adresse_spedition_id;