CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_GJMO_SPR_ZU_RO_2 as

     SELECT gjmo,
     TRIM( mo_bez)  ||  ' GJ ' ||  cast(gj AS CHAR(4))  AS gjmo_bez


     FROM dbp_view.v_monat_2 v01
     INNER JOIN dbp_view.v_monat_spr_zu_2 v02
     ON v01.mo_kj =v02.mo_id
     WHERE v02.spr_id=95;