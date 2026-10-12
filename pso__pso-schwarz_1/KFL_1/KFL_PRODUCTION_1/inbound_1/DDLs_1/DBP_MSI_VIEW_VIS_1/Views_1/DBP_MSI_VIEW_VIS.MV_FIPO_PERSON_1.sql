CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_PERSON_1 as

   SELECT

   v01.fipo_person_id, v01.mandant_id, v01.fipo_pos_id, v01.rev_fb_id, v01.fipo_person_organisation, v01.fipo_person_name, v01.fipo_person_vorname, v01.fipo_person_anrede, v01.fipo_person_name || ', ' || v01.fipo_person_vorname AS fipo_person_name_lang, CASE WHEN v01.fipo_person_organisation = 'TESTKUNDE' THEN 'Testkunde' ELSE v01.fipo_person_name || ', ' || v01.fipo_person_vorname END AS fipo_person_name_anonym --Vertrieb darf keine Testkundennamen sehen
   , v01.dat_bis

   FROM dbp_view.v_fipo_person_1 v01

   WHERE v01.fipo_person_organisation IS NOT NULL
   ;