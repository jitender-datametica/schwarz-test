CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_KMO.TBL_MV_WEWA_2
(
MANDANT_ID,
	WEWA_BELEG_ID,
	WEWA_BELEG_POS_ID,
	WEWA_JAHR,
	ART_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	LAGER_BEWART_ID,
	DAT_BUCH,
	MENGE_BASIS,
	WEWA_STATUS,
	WRG_ID,
	BETRAG_EK_NETTO,
	BETRAG_VK_NETTO,
	KONDITIONSBETRAG_ZAR5,
	EINSTANDSPREIS_V02,
	EK_BRUTTO_V02,
	EK_BRUTTO_NORMAL_V02,
	EK_NETTONETTO_V02,
   EK_MEP_VOR_FWU_V02,
   EK_MEP_V02,
	EK_KALKULATIONSBASIS_V02,
	EK_KALKULATIONSBASIS_OHNE_FWU_V02,
   EINSTANDSPREIS_V03,
	EK_BRUTTO_V03,
	EK_BRUTTO_NORMAL_V03,
	EK_NETTONETTO_V03,
   EK_MEP_VOR_FWU_V03,
   EK_MEP_V03,
	EK_KALKULATIONSBASIS_V03,
	EK_KALKULATIONSBASIS_OHNE_FWU_V03,
	UMRECHNUNGSKURS_0,
   UMRECHNUNGSKURS_1,
	POSTEN_KZ_PER
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_KMO
AS
   --   03.04.2012 AL neu erstellt
   -- 19.09.2012 AL ergänzt um ekn2 (ek_nettonetto)
   -- 05.11.2012 AL Datentypanpassung EK nettonetto und Einstandspreis auf NUMBER(38,5)
   -- 03.07.2013 #585784 sschücke / Erweiterung um Feld betrag_vk_netto
   --25.11.2019 SPEC0066248 -fields konditionsbetrag_zar5 and ek_brutto added
   -- 21.11.2023 staeblern / Umbenennung der Spalte Betrag zu betrag_ek_netto
   SELECT
   v01.MANDANT_ID,
   wewa_beleg_id,
   wewa_beleg_pos_id,
   wewa_jahr,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.gp_id,
   v01.lager_bewart_id,
   v01.dat_buch,
   menge_basis,
   v01.status_2    AS wewa_status,
   v01.wrg_id,
   v01.betrag_ek_netto,
   v01.betrag_vk_netto,
   v01.konditionsbetrag_zar5,
   v02.einstandspreis AS einstandspreis_v02,
   v02.ek_brutto AS ek_brutto_v02,
   v02.ek_brutto_normal AS ek_brutto_normal_v02,
   v02.ek_nettonetto AS ek_nettonetto_v02,
   v02.ek_mep_vor_fwu AS EK_MEP_VOR_FWU_V02,
   v02.ek_mep AS EK_MEP_V02,
   v02.ek_kal_basis AS ek_kalkulationsbasis_v02,
   v02.ek_kal_basis+(v02.ek_mep_vor_fwu-v02.ek_mep) AS ek_kalkulationsbasis_ohne_fwu_v02,
   v03.einstandspreis AS einstandspreis_v03,
   v03.ek_brutto AS ek_brutto_v03,
   v03.ek_brutto_normal AS ek_brutto_normal_v03,
   v03.ek_nettonetto AS ek_nettonetto_v03,
   v03.ek_mep_vor_fwu AS EK_MEP_VOR_FWU_V03,
   v03.ek_mep AS EK_MEP_V03,
   v03.ek_kal_basis AS ek_kalkulationsbasis_v03,
   v03.ek_kal_basis+(v03.ek_mep_vor_fwu-v03.ek_mep) AS ek_kalkulationsbasis_ohne_fwu_v03,
   v300.umrechnungskurs AS umrechnungskurs_0,
   v400.umrechnungskurs AS umrechnungskurs_1,
   CASE WHEN v04.POSTEN_ID NOT IN ('1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS posten_kz_per

   FROM dbp_data.wewa_2 v01
   LEFT OUTER JOIN
   --ZEKP_2 Auflösung, marktspezifische Preise
   (
   SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
   einstandspreis,
   ek_nettonetto,
   ek_mep_vor_fwu,
   ek_mep,
   ek_kal_basis,
   ek_brutto,
   ek_brutto_normal
  FROM dbp_data.art_gp_wup_zu_per_2
  WHERE mandant_id > 1 AND wup_id > -1
  ) v02
   ON
   v01.mandant_id = v02.mandant_id AND
   v01.wup_id     = v02.wup_id        AND
   v01.gp_id          = v02.gp_id          AND
   v01.art_id          =  v02.art_id AND
   dat_buch BETWEEN v02.dat_von AND v02.dat_bis
   LEFT OUTER JOIN
   --ZEKP_2 Auflösung allgemeingeltende Preise
   (
   SELECT mandant_id,
   art_id,
   gp_id,
   wup_id,
   dat_von,
   dat_bis,
   einstandspreis,
   ek_nettonetto,
   ek_mep_vor_fwu,
   ek_mep,
   ek_kal_basis,
   ek_brutto,
   ek_brutto_normal
  FROM dbp_data.art_gp_wup_zu_per_2
  WHERE mandant_id > 1 AND wup_id = -1
  ) v03
   ON
   v01.mandant_id=  v03.mandant_id AND
   v01.gp_id          =  v03.gp_id          AND
   v01.art_id          =  v03.art_id AND
   dat_buch BETWEEN v03.dat_von AND v03.dat_bis
   
   /*-- Umrechnung Standardkurs, Tageskurs
   JOIN
   dbp_view.v_kurs_2 v300
   ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

    -- JOIN aktueller Berichtskurs
   JOIN dbp_data.kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND v01.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_data.kurs_2 v400
   ON v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
   AND v01.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   LEFT JOIN dbp_data.art_per_2 v04
	ON v01.art_id = v04.art_id
	AND v01.mandant_id = v04.mandant_id
	AND v01.dat_buch BETWEEN v04.dat_von-1 AND v04.dat_bis-1 

   WHERE v01.mandant_id <> 1;