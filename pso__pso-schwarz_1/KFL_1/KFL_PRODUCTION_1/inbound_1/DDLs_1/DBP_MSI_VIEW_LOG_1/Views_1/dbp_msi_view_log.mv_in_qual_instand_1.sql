CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_QUAL_INSTAND_1(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	AUSFALL_FG,
	AUSFALLZEIT_SEKUNDEN,
	AUFTRAG_ID,
	AUFTRAGSART_ID,
	DAT_BUCH,
	WERK_ID,
	TP_OBJEKT_ID
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial
--2023-03-20, dknop adding dat_buch logic
--2024-08-27, AP0226234,SPEC0255818, dknop, change tp_objekt_id source from v_in_instandhaltung_objekt_qual_1 to v_in_instandhaltung_1
   SELECT
 in_q.mandant_id
,in_q.qual_meldung_id
,in_q.ausfall_fg
,in_q.ausfallzeit_sekunden
,inst.auftrag_id
,auftragsart_id
,dat_buch
,in_a.werk_id
,inst.tp_objekt_id
   FROM dbp_view.v_in_qual_instand_1 in_q
   
   JOIN dbp_view.v_in_instandhaltung_1 inst
   ON in_q.qual_meldung_id= inst.qual_meldung_id
   AND in_q.mandant_id= inst.mandant_id
   
   JOIN dbp_view.v_in_auftrag_1 in_a
   ON inst.auftrag_id = in_a.auftrag_id
   AND inst.mandant_id = in_a.mandant_id
   
   JOIN (SELECT
    v01.auftrag_id
   ,v01.mandant_id
   ,COALESCE(MAX(v02.dat_buch),MAX(v03.dat_start)) AS dat_buch
   FROM dbp_view.v_in_auftrag_1 v01
   LEFT OUTER JOIN 
   (SELECT DISTINCT
    mandant_id
   ,auftrag_id
   ,dat_buch
   FROM dbp_view.v_in_auftrag_rm_1) v02
   ON v01.auftrag_id = v02.auftrag_id
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN 
   (SELECT
    auftrag_id
   ,mandant_id
   ,dat_start
    FROM dbp_view.v_in_auftrag_pps_1
   ) v03
   ON v01.auftrag_id = v03.auftrag_id
   AND v01.mandant_id = v03.mandant_id
  GROUP BY
    v01.auftrag_id
   ,v01.mandant_id) dat
   ON inst.mandant_id = dat.mandant_id
   AND inst.auftrag_id = dat.auftrag_id
   ;