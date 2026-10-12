CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_WG_VERKETTUNG_HIERARCHIE_PER_1 AS 
    SELECT 
         mandant_id
        ,wup_id
        ,nb_id
        ,wg_verkett_hier_id
        ,palettenlaenge
        ,palettenbreite
        ,palettenhoehe
        ,palettengroesse_einh_id
        ,palettenvolumen
        ,palettenvolumen_einh_id
        ,volumenabw_max
        ,volumen_max
        ,akl_komm_fg
        ,klapp_pal_fg
        ,volumengrenze_kkp
        ,dat_von
        ,dat_bis

FROM DBP_DATA.WUP_WG_VERKETTUNG_HIERARCHIE_PER_1 ;