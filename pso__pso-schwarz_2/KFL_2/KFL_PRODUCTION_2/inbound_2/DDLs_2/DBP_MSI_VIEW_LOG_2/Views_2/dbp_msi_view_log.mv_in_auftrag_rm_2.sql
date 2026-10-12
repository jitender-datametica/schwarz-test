CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_AUFTRAG_RM_2(
	MANDANT_ID,
	AUFTRAG_ID,
--	CO_LEISTUNGSART_ID,
	STORNO_FG,
	STORNO_ZAEHLER,
	DAT_BUCH,
  QUAL_MELDUNG_ID
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
--2022-08-19, AP0133256,SPEC0166769,dknop, adding join to in_auftrag_2 to have full list of auftrag
--2023-01-20, AP0133256,SPEC0166769,dknop, removing co_leistungsart_id, it causing duplicates
--2023-02-20, AP0133256,SPEC0166769,dknop, adding join to v_in_instandhaltung_objekt_qual_2 for qual_meldung_id
SELECT DISTINCT
    in_auf.mandant_id
   ,in_auf.auftrag_id
   -- ,COALESCE (co_leistungsart_id,'-1')
   ,COALESCE (storno_fg,0)
   ,COALESCE (storno_zaehler,NULL)
   ,COALESCE (dat_buch,NULL)
   ,COALESCE (qual_meldung_id,NULL)
   FROM dbp_view.v_in_auftrag_2 in_auf 
 LEFT JOIN dbp_view.v_in_auftrag_rm_2 in_auf_rm
 ON in_auf.auftrag_id=in_auf_rm.auftrag_id
 AND in_auf.mandant_id=in_auf_rm.mandant_id
 LEFT JOIN dbp_view.v_in_instandhaltung_objekt_qual_2 in_obj_q
 ON in_auf.auftrag_id=in_obj_q.auftrag_id
 AND in_auf.mandant_id=in_obj_q.mandant_id
;