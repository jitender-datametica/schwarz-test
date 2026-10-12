CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_AUFTRAG_RM_POS_1(
	MANDANT_ID,
	AUFTRAG_ID,
	AUFTRAG_KURZTEXT,
	WERK_ID,
	CO_LEISTUNGSART_ID,
	STORNO_FG,
	STORNO_ZAEHLER,
	DAT_BUCH,
	TEIL_END_RM,
	AUFTRAG_RM_POS_ID,
	AUFTRAGSART_ID,
	TP_OBJEKT_ID
) AS
--2022-12-20, AP0133256,SPEC0166769,dknop, initial
--2023-01-16, AP0133256,SPEC0166769,dknop, adding teil_end_rm
--2023-03-02, dknop, adding some additional columns from in_auftrag_1
--2023-04-26, dknop, adding tp_objekt_id
--2024-08-27, AP0226234,SPEC0255818, dknop, change tp_objekt_id source from v_in_instandhaltung_objekt_qual_1 to v_in_instandhaltung_1
SELECT DISTINCT
    in_auf.mandant_id
   ,in_auf.auftrag_id
   ,in_auf.auftrag_kurztext
   ,in_auf.werk_id
   ,COALESCE (co_leistungsart_id,'-1') AS co_leistungsart_id
   ,COALESCE (storno_fg,0) AS storno_fg
   ,COALESCE (storno_zaehler,NULL) AS storno_zaehler
   ,COALESCE (dat_buch,NULL) AS dat_buch
   ,COALESCE (in_auf_rm.teil_end_rm,NULL) AS teil_end_rm
   ,in_auf_rm.auftrag_rm_pos_id
   ,in_auf.auftragsart_id
   ,COALESCE(tp_objekt_id,'-1') AS tp_objekt_id
 FROM dbp_view.v_in_auftrag_1 in_auf 
 LEFT JOIN dbp_view.v_in_auftrag_rm_1 in_auf_rm
 ON in_auf.auftrag_id=in_auf_rm.auftrag_id
 AND in_auf.mandant_id=in_auf_rm.mandant_id
 LEFT JOIN dbp_view.v_in_instandhaltung_1 inst
   ON in_auf.auftrag_id = inst.auftrag_id
   AND in_auf.mandant_id = inst.mandant_id
 /*  UNION
SELECT distinct  mandant_id
   ,auftrag_id
   ,'-1'
   ,storno_fg
   ,storno_zaehler
   ,dat_buch
   FROM dbp_view.v_in_auftrag_rm_1*/


    

    ;