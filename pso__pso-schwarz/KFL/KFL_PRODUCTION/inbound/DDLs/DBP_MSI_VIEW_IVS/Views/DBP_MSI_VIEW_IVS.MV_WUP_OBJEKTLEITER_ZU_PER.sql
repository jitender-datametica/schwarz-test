CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_WUP_OBJEKTLEITER_ZU_PER as
      SELECT
      o.zustaendig_id Mitarbeiter_ID,
      o.mandant_id,
      o.immo_objekt_id,
      o.dat_von,
      o.dat_bis,
      o.buchungskreis_id,
      o.kostenstelle_id
      FROM dbp_view.v_ivs_objekt_zustaendig_zu_per o
      WHERE o.zustaendig_typ_id = 2
      AND o.dat_bis = '9999-12-31';