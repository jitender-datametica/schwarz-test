CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_AUFTRAG_1(
	AUFTRAG_ID,
	MANDANT_ID,
	AUFTRAGSART_ID,
	GESCHAEFTSBEREICH_ID,
	IN_BUDGET_TYP_ID,
	IN_MASSNAHME_TYP_ID,
	AUFTRAG_TYP_ID,
	PSP_ID,
	TECHN_PLATZ_ID,
	WERK_ID,
	PHAS_TECHN_ABSCHLUSS_FG,
	AUFTRAG_KURZTEXT,
	DAT_BUCH
) AS

--2022-08-19, AP0133256,SPEC0166769,dknop, initial
   SELECT
    v01.auftrag_id
   ,v01.mandant_id
   ,v01.auftragsart_id
   ,v01.geschaeftsbereich_id
   ,v01.in_budget_typ_id
   ,v01.in_massnahme_typ_id
   ,v01.auftrag_typ_id
   ,v01.psp_id
   ,v01.techn_platz_id
   ,v01.werk_id
   ,v01.phas_techn_abschluss_fg
   ,v01.auftrag_kurztext
   ,COALESCE(MAX(v02.dat_buch),MAX(v03.dat_start)) AS dat_buch

   FROM dbp_view.v_in_auftrag_1 v01
   LEFT OUTER JOIN 
   (SELECT DISTINCT
    mandant_id
   ,auftrag_id
   ,co_leistungsart_id
   ,storno_fg
   ,storno_zaehler
   ,dat_buch
   FROM dbp_view.v_in_auftrag_rm_1) v02
   ON v01.auftrag_id = v02.auftrag_id
   AND v01.mandant_id = v02.mandant_id
   
   LEFT OUTER JOIN 
   (SELECT
    auftrag_id
   ,mandant_id
   ,dat_start
   ,auftrag_rm_id
   ,auftrag_rm_pos_id
   ,dat_planaufloesung
   FROM dbp_view.v_in_auftrag_pps_1) v03
   ON v01.auftrag_id = v03.auftrag_id
   AND v01.mandant_id = v03.mandant_id

   GROUP BY
    v01.auftrag_id
   ,v01.mandant_id
   ,v01.auftragsart_id
   ,v01.geschaeftsbereich_id
   ,v01.in_budget_typ_id
   ,v01.in_massnahme_typ_id
   ,v01.auftrag_typ_id
   ,v01.psp_id
   ,v01.techn_platz_id
   ,v01.werk_id
   ,v01.phas_techn_abschluss_fg
   ,v01.auftrag_kurztext;