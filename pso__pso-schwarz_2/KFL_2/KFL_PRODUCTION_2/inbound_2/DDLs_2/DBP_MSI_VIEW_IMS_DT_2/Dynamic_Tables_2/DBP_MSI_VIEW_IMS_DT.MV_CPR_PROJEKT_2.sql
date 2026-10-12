CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_CPR_PROJEKT_2
(
	PROJEKT_ID,
	PROJEKT_EXT_ID,
	IN_PROJEKT_ID,
	MANDANT_ID,
	TECHN_PLATZ_ID,
	TECHN_PLATZ_EBENE_ID,
	MASSNAHME_KZ,
	CPR_KATEGORIE_ID,
	PROJEKT_ANLASS_ID,
	PROJEKTART_ID,
	CPR_PROJEKT_GRUPPE_ID,
	DAT_FREIGABE,
	PL_BE_NAME,
	INVESTOR_EIGENOBJ,
	CPR_EIG_PROJ,
	CPR_BL_PROJEKT_BAU_EINR_NAME,
	CPR_PROJEKT_LANGTEXT,
	KBL_NL_BEZ,
	TP_BETREUER_KBL_NAME,
	TP_BL_KBL_NAME,
	MASSNAHME_ID
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 12.04.2013 twie: Kopie aus IOS für Projektentwickler
-- 12.06.2013 twie: Verbindung zu in_projekt_2
-- 26.06.2013 twie: Neuaufbau View; alle Projekte ausgeben, wenn vorhanden cpr projekt dazu
-- 07.07.2014 twie: Langtext übernommen aus IOS mv_cpr_projekt_spr_zu_2
-- 18.07.2014 twie: techn_platz_ebene_2_per_2 joinen und damit Niederlassung ausgeben
-- 28.08.2015 twie: weitere 3 Felder ergänzt: cpr_bl_projekt_bau_einr_name,  tp_betreuer_kbl_name, tp_bl_kbl_name
-- 23.07.2019 twie: SPEC0059595 Verbindung zu neuem Attribut Massnahmenart

   SELECT
   pr.projekt_id,
   pr.cpr_ext_id AS projekt_ext_id,
   inpr.in_projekt_id,
   inpr.mandant_id,
   TRIM(pr.techn_platz_id)  AS techn_platz_id,
   2  AS techn_platz_ebene_id,
   pr.massnahme_id AS massnahme_kz,
   pr.cpr_kategorie_id,
   pr.projekt_anlass_id,
   pr.projektart_id,
   CAST(NULL AS VARCHAR(40))  AS cpr_projekt_gruppe_id,
   pr.dat_freigabe,
   COALESCE(pr.pl_be_name, '') AS pl_be_name,
   COALESCE(pr.investor_eigenobj, '') AS investor_eigenobj,
   COALESCE(pr.cpr_eig_proj, '') AS cpr_eig_proj,
   COALESCE(pr.cpr_bl_projekt_bau_einr_name, '') AS cpr_bl_projekt_bau_einr_name --Bereichsleiter Projekte Bau Einr.
   ,
   COALESCE(pr.cpr_projekt_langtext_de,'')  || ' ' ||  COALESCE(pr.cpr_projekt_langtext, '') AS cpr_projekt_langtext,
   COALESCE(tp2.kbl_nl_bez,'') AS kbl_nl_bez  --Niederlassung
   ,
   COALESCE(tp2.tp_betreuer_kbl_name,'') AS tp_betreuer_kbl_name --Betreuer Bau Einr
   ,
   COALESCE(tp2.tp_bl_kbl_name,'') AS tp_bl_kbl_name --Bereichsleiter Betreuung Bau Einr.
   ,
   COALESCE(pr.massnahme_id, '') AS massnahme_id

   FROM dbp_view.v_in_projekt_2 inpr
   LEFT OUTER JOIN
   (
   SELECT
   v04.*,
   v02.cpr_projekt_langtext AS cpr_projekt_langtext_de,
   v03.cpr_projekt_langtext
   FROM dbp_view.v_cpr_projekt_per_2 v04
   LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per_2  v02
   ON  v02.projekt_id = v04.projekt_id
   AND v02.spr_id=22
   LEFT JOIN dbp_view.v_mandant_spr_zu_2 v06
   ON v04.mandant_id= v06.mandant_id
   LEFT JOIN dbp_view.v_cpr_projekt_spr_zu_per_2  v03
   ON v02.projekt_id = v03.projekt_id
   AND v03.spr_id =v06.spr_id
   AND v03.spr_id<>22

   WHERE
   (v02.dat_bis = '9999-12-31' OR v02.dat_bis IS NULL)
   AND (v03.dat_bis = '9999-12-31' OR v03.dat_bis IS NULL)
   AND v04.dat_bis = '9999-12-31'

   )  pr
   ON inpr.projekt_ext_id =  pr.cpr_ext_id
   LEFT OUTER JOIN dbp_view.v_techn_platz_ebene_2_per_2 tp2
   ON pr.techn_platz_id = tp2.techn_platz_id
   AND tp2.dat_bis = '9999-12-31'
   ;