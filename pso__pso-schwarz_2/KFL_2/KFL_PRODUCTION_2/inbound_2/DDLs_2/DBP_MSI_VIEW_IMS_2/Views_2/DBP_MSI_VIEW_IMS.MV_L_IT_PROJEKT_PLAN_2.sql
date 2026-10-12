CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IT_PROJEKT_PLAN_2 AS
-- 04.04.2013 AL Init
-- 19.10.2017 twie: RITM0414617aktivierungsquote_intern in Tabelle ersetzt durch aktivierungsquote_intern_plan, ebenso bei extern
-- 03.01.2019 twie: SPEC0046436 Umbau der Stuktur auf neue Tabelle, befüllt aus Clarity

   SELECT
   plan_revision_id AS plan_version_id,
   it_projekt_id,
   sonstiger_aufwand,
   aktivierungsquote_intern_plan AS aktivierungsquote_intern,
   aktivierungsquote_extern_plan AS aktivierungsquote_extern,
   dat_von,
   dat_bis

  FROM dbp_view.v_it_projekt_plan_2
;