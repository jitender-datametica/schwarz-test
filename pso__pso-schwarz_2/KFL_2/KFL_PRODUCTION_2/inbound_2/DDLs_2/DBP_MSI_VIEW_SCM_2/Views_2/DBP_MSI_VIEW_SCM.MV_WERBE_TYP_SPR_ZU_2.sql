CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WERBE_TYP_SPR_ZU_2 as
SELECT
wsz.werbe_typ_id as werbe_typ_id,
max(wsz.werbe_typ_bez) as werbe_typ_bez,
listagg(TRIM(m.mandant_kbez), ', ') within group (ORDER BY m.mandant_id ASC) as werbe_typ_mandanten,
werbe_typ_id || ': ' || max(wsz.werbe_typ_bez) ||' (' ||  werbe_typ_mandanten ||  ')' as werbe_typ_bez_lang
FROM dbp_view.v_werbe_typ_spr_zu_2 wsz
join dbp_view.v_mandant_2 m
on wsz.mandant_id=m.mandant_id
group by wsz.werbe_typ_id;