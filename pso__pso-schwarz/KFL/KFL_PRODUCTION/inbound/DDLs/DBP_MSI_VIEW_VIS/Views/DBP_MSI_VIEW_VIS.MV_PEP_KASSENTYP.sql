CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_PEP_KASSENTYP as
   -- LOOKUP : Kassentyp fuer PEP-Auswertung
   -- Verwendung in Freeform-SQL Cube
   -- 2012KW37: Initial

   SELECT
   v01.mandant_id, v01.nb_id, v01.wup_id, v01.pep_typ_id, v01.kasse_von, v01.kasse_bis
   FROM dbp_msi_v_view.v_pep_kassentyp  v01;