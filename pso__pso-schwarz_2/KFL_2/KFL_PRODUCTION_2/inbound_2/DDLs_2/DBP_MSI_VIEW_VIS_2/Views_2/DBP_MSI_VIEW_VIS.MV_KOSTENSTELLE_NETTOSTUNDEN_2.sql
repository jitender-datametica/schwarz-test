CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KOSTENSTELLE_NETTOSTUNDEN_2 as
   -- FAKT : Stunden_2 pro Filiale/Kostenstelle/Bereich/Tag_2
   -- 2018.0809 ssch0611 : Initial (1:1)

   SELECT
   mandant_id, nb_id, wup_id, krk_id, kostenstelle_id, hr_objekt_bez_kurz, hr_objekt_bereich_id, dat, stunden_netto, stunden_netto_plan, stunden_netto_markt_pep
   FROM dbp_view.v_kostenstelle_nettostunden_2
;