CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_INSTANDHALTUNG_OBJEKT_QUAL_2(
	MANDANT_ID,
	QUAL_MELDUNG_ID,
	TP_OBJEKT_ID,
	AUFTRAG_ID,
	TECHN_PLATZ_ID,
	DAT_STOER_BEGINN
) AS
--2022-08-19, AP0133256,SPEC0166769,dknop, initial
   SELECT
    v01.mandant_id
   ,v01.qual_meldung_id
   ,v01.tp_objekt_id
   ,v01.auftrag_id
   ,v01.techn_platz_id
   ,v01.dat_stoer_beginn
   FROM dbp_view.v_in_instandhaltung_objekt_qual_2 v01;