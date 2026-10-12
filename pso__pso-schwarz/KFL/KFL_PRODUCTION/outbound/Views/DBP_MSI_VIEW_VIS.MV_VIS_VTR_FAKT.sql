create or replace view kfl_production_dbp_msi_view_vis.mv_vis_vtr_fakt
(
    mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, vtr_id,
    filist, filist2, filkvj, filkvj2, filplan, filplan2,
    regist, regist2, regkvj, regkvj2, landist, landist2, landkvj, landkvj2,
    filmo_rang, filgj_rang, vklmo_rang, vklgj_rang,
    filmo_wert, filgj_wert, vklmo_wert, vklgj_wert
) as 


with 
monat_fakt_wup as ( 
    select 
        vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id,
        wup.vs_id, 
        case when wup.vkl_id > 0 then wup.vkl_id else cast((1000 + vis.mandant_id * 100 + wup.vs_id * 10) * -1 as int64) end as vkl_id,
        coalesce(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) as neo_dat,
        wup.dat_bis as stl_dat,
        zeit.gj, zeit.kjmo, zeit.max_dat,
        ker.akt_buchungs_schluss as akt_bs,
        sum(vis.ums_netto)       as ums_ist,
        sum(vis.ums_netto_kvj)   as ums_kvj,
        sum(vis.ums_netto_plan)  as ums_plan,
        sum(vis.anz_kunde)       as knd_ist,
        sum(vis.anz_kunde_kvj)   as knd_kvj,
        safe_divide(sum(vis.anz_kunde), 10000) as knd_10t_ist,
        safe_divide(sum(vis.anz_kunde_kvj), 10000) as knd_10t_kvj,
        sum(vis.pers_std)        as std_ist,
        sum(vis.pers_std_kvj)    as std_kvj,
        sum(vis.pers_std_plan)   as std_plan,
        sum(vis.pers_kosten)     as kst_ist,
        sum(vis.pers_kosten_kvj) as kst_kvj,
        sum(vis.pers_kosten_plan) as kst_plan
    from `kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup` vis
    inner join `kfl_production_dbp_data.monat` zeit
        on zeit.kjmo = vis.kjmo and zeit.akt_gj in (-1, 0) and zeit.akt_mo < 0 
    inner join `kfl_production_dbp_data.l_buchungsstatus_ker` ker
        on ker.kj_ker_mo_id = vis.kjmo
    inner join `kfl_production_dbp_data.wup` wup 
        on wup.wup_id = vis.wup_id and wup.mandant_id = vis.mandant_id 
        and (wup.nb_id=0 or wup.wup_id in (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
        and wup.dat_eroeffnung < date '2090-12-31' 
        and (extract(year from wup.dat_bis) + case when extract(month from wup.dat_bis) < 3 then -1 else 0 end) > (zeit.gj + 1) 
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
),
monat_fakt_wg as ( 
    select 
        vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id,
        wup.vs_id, 
        case when wup.vkl_id > 0 then wup.vkl_id else cast((1000 + vis.mandant_id * 100 + wup.vs_id * 10) * -1 as int64) end as vkl_id,
        coalesce(wup.dat_eroeffnung_alt, wup.dat_eroeffnung) as neo_dat,
        wup.dat_bis as stl_dat,
        zeit.gj, zeit.kjmo, zeit.max_dat,
        ker.akt_buchungs_schluss as akt_bs,
        sum(vis.ums_netto)      as ums_ist,
        sum(vis.ums_netto_kvj)  as ums_kvj,
        sum(vis.menge)          as mng_ist,
        sum(vis.menge_kvj)      as mng_kvj,
        sum(case when vis.abt_id = 5 then vis.ums_netto else 0 end)      as ums_uf_ist,
        sum(case when vis.abt_id = 5 then vis.ums_netto_kvj else 0 end)  as ums_uf_kvj,
        sum(case when wg.owg_id <> 1092 then vis.menge else 0 end)       as mng_opf_ist,
        sum(case when wg.owg_id <> 1092 then vis.menge_kvj else 0 end)   as mng_opf_kvj
    from `kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wg` vis
    join `kfl_production_dbp_msi_view_vis.mv_wg_int` wg on wg.wg_id = vis.wg_id
    inner join `kfl_production_dbp_data.monat` zeit on zeit.kjmo = vis.kjmo and zeit.akt_gj in (-1, 0) and zeit.akt_mo < 0 
    inner join `kfl_production_dbp_data.l_buchungsstatus_ker` ker on ker.kj_ker_mo_id = vis.kjmo
    inner join `kfl_production_dbp_data.wup` wup 
        on wup.wup_id = vis.wup_id and wup.mandant_id = vis.mandant_id 
        and (wup.nb_id=0 or wup.wup_id in (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
        and wup.dat_eroeffnung < date '2090-12-31' 
        and (extract(year from wup.dat_bis) + case when extract(month from wup.dat_bis) < 3 then -1 else 0 end) > (zeit.gj + 1) 
    group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
), 
tag_abschriften_wg as ( 
    select 
        vis.mandant_id, vis.wup_id, vis.wrg_id, zeit.kjmo,
        sum(case 
            when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
            when vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
            when vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
            when vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
            when vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
            else -1 end * vis.abschrift_netto) as abs_op_ist,
        sum(case 
            when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
            when vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
            when vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
            when vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
            when vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
            else -1 end * vis.abschrift_netto_kvj) as abs_op_kvj, 
        sum(case when vis.abt_id = 5 
            then case
                when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
                when vis.abt_id = 5 and vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
                when vis.abt_id = 5 and vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
                when vis.abt_id = 5 and vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
                when vis.abt_id = 5 and vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
                else -1 end
            else 0 end * vis.abschrift_netto) as abs_uf_ist,
        sum(case when vis.abt_id = 5 then case
                when vis.abt_id = 5 and vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
                when vis.abt_id = 5 and vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
                when vis.abt_id = 5 and vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
                when vis.abt_id = 5 and vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
                when vis.abt_id = 5 and vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
                else -1 end
            else 0 end * vis.abschrift_netto_kvj) as abs_uf_kvj,
        sum(case when abs_thema.abschriftart_thema_int_id = 1 
            then case
                when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
                when vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
                when vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
                when vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
                when vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
                else -1 end
            else 0 end * vis.abschrift_netto) as abs_ta_ist,
        sum(case when abs_thema.abschriftart_thema_int_id = 1 
            then case 
                when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
                when vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
                when vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
                when vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
                when vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
                else -1 end
            else 0 end * vis.abschrift_netto_kvj) as abs_ta_kvj,
        sum(case when abs_thema.abschriftart_thema_int_id = 4 
            then case
                when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
                when vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
                when vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
                when vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
                when vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
                else -1 end
            else 0 end * vis.abschrift_netto) as abs_pa_ist,
        sum(case when abs_thema.abschriftart_thema_int_id = 4 
            then case 
                when vis.mandant_id in (6) and vis.abschriftart_id = 2 then 1 
                when vis.mandant_id in (3) and vis.abschriftart_id = 11 then 1 
                when vis.mandant_id in (2,4,5,7,8) and vis.abschriftart_id = 7 then 1 
                when vis.mandant_id in (2,5) and vis.abschriftart_id = 10 then 1 
                when vis.mandant_id not in (1) and vis.abschriftart_id = 20 then 1 
                else -1 end
            else 0 end * vis.abschrift_netto_kvj) as abs_pa_kvj
    from `kfl_production_dbp_msi_view_vis.mv_vis_tag_abschriften_wg` vis
    join `kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu` abs_art
        on abs_art.abschriftart_id = vis.abschriftart_id and abs_art.mandant_id = vis.mandant_id 
    join `kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu` abs_thema
        on abs_thema.abschriftart_int_id = abs_art.abschriftart_int_id
        and abs_thema.abschriftart_thema_int_id in (1, 4)
    inner join `kfl_production_dbp_data.tag` zeit1 on zeit1.dat = vis.dat
    inner join `kfl_production_dbp_data.monat` zeit on zeit.kjmo = zeit1.kjmo and zeit.akt_gj in (-1, 0) and zeit.akt_mo < 0 
    inner join `kfl_production_dbp_data.wup` wup 
        on wup.wup_id = vis.wup_id and wup.mandant_id = vis.mandant_id 
        and (wup.nb_id=0 or wup.wup_id in (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
        and wup.dat_eroeffnung < date '2090-12-31' 
        and (extract(year from wup.dat_bis) + case when extract(month from wup.dat_bis) < 3 then -1 else 0 end) > (zeit.gj + 1) 
    group by 1, 2, 3, 4
), 
tag_fwws_wg as ( 
    select 
        vis.mandant_id, vis.nb_id, vis.wup_id,
        zeit.kjmo,
        sum(vis.anz_artikel_autodispo_dm12) as auto_dispo,
        sum(vis.anz_artikel_exc214)         as minus_best,
        sum(case when vis.dispomerkmal in ('10', '11', '14') or vis.mandant_id <> 1 then vis.anz_artikel_exc209 else null end) as null_best
    from `kfl_production_dbp_msi_view_vis.mv_vis_tag_fwws_wg` vis
    inner join `kfl_production_dbp_data.monat` zeit on zeit.kjmo = vis.kjmo and zeit.akt_gj in (-1, 0) and zeit.akt_mo < 0
    inner join `kfl_production_dbp_data.wup` wup 
        on wup.wup_id = vis.wup_id and wup.mandant_id = vis.mandant_id 
        and (wup.nb_id=0 or wup.wup_id in (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
        and wup.dat_eroeffnung < date '2090-12-31' 
        and (extract(year from wup.dat_bis) + case when extract(month from wup.dat_bis) < 3 then -1 else 0 end) > (zeit.gj + 1) 
    where vis.abt_id in (5,6,7,8) 
    group by 1, 2, 3, 4
), 
zaehl_auftrag as ( 
    select 
        vis.mandant_id, vis.nb_id, vis.wup_id,
        zeit.kjmo,
        sum(case when vis.dat_auftrag is not null then 1 else 0 end) as auftrag,
        sum(case when vis.dat_zaehl   is not null then 1 else 0 end) as gezaehlt
    from `kfl_production_dbp_msi_view_vis.mv_vis_zaehl_auftrag` vis
    inner join `kfl_production_dbp_data.tag` zeit1 on zeit1.dat = vis.dat_auftrag
    inner join `kfl_production_dbp_data.monat` zeit on zeit.kjmo = zeit1.kjmo and zeit.akt_gj in (-1, 0) and zeit.akt_mo < 0
    inner join `kfl_production_dbp_msi_view_vis.mv_art_wg_zu` art on art.art_id = vis.art_id and art.mandant_id = vis.mandant_id
    inner join `kfl_production_dbp_msi_view_vis.mv_wg_int` wg on wg.wg_id = art.wg_id
    inner join `kfl_production_dbp_msi_view_vis.mv_owg_int` owg on owg.owg_id = wg.owg_id
    inner join `kfl_production_dbp_msi_view_vis.mv_hwg_int` hwg on hwg.hwg_id = owg.hwg_id
    inner join `kfl_production_dbp_data.wup` wup 
        on wup.wup_id = vis.wup_id and wup.mandant_id = vis.mandant_id 
        and (wup.nb_id=0 or wup.wup_id in (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124))
        and wup.dat_eroeffnung < date '2090-12-31' 
        and (extract(year from wup.dat_bis) + case when extract(month from wup.dat_bis) < 3 then -1 else 0 end) > (zeit.gj + 1) 
    where vis.zaehl_grund_id in ('214','299','300','301','310','311','320','330','340','350','360','814','999') 
    and hwg.abt_id in (5,6,7,8) 
    group by 1, 2, 3, 4
),
/* helper for sorting logic that repeats frequently */
prep_sorting as (
    select 
        sub.*,
        case when sub.stl_dat > sub.max_dat 
            and sub.gj > (extract(year from sub.neo_dat)+case when extract(month from sub.neo_dat)<3 then -1 else 0 end)+1 
            and sub.nb_id=0 
            and not ( 
                (sub.mandant_id=1 and sub.wup_id in (1263,1273,2583,3166,6623,7220,8120,8563,8940,5876)) 
                or (sub.mandant_id=7 and sub.wup_id in (1110,1410,6210,6310,6410)) 
                or (sub.mandant_id=3 and sub.wup_id in (1010)) 
            ) then 1 else 0 end as neo_fg,
        case when sub.stl_dat between parse_date('%y-%m-%d', concat(cast(sub.gj as string), '-03-01')) 
          and date_sub(date_add(parse_date('%y-%m-%d', concat(cast(sub.gj as string), '-03-01')), interval 12 month), interval 1 day)
          then 0 else 1 end as stl_fg,
        case when sub.nb_id=0 and sub.vkl_id>0 then 1 else 0 end as zf_fg,
        case when sub.akt_bs <= 0 then 1 else 0 end as bs_fg
    from monat_fakt_wup sub
)

/* -------------------------------------------
   main selects (vtr100 - vtr755)
   ------------------------------------------- */

-- vtr100
select mandant_id, nb_id, vs_id, vkl_id, wup_id, wrg_id, gj, kjmo, cast(100 as int64) as vtr_id 
, ist_fil  as filist,  null as filist2 
, kvj_fil  as filkvj,  null as filkvj2 
, plan_fil as filplan, null as filplan2 
, ist_reg  as regist,  null as regist2 
, kvj_reg  as regkvj,  null as regkvj2 
, ist_land as landist, null as landist2 
, kvj_land as landkvj, null as landkvj2 
, case when bs_fg*neo_fg=1 then dense_rank() over (partition by mandant_id, wrg_id, kjmo, vs_id order by fil_mo desc nulls last) end
, case when neo_fg*stl_fg=1 then dense_rank() over (partition by mandant_id, wrg_id, gj, vs_id order by fil_gj desc nulls last) end
, case when bs_fg*zf_fg=1 then dense_rank() over (partition by mandant_id, wrg_id, kjmo, vs_id order by vkl_mo desc nulls last) end
, case when zf_fg*stl_fg=1 then dense_rank() over (partition by mandant_id, wrg_id, gj, vs_id order by vkl_gj desc nulls last) end
, case when bs_fg*neo_fg=1 then fil_mo end
, case when neo_fg*stl_fg=1 then fil_gj end
, case when bs_fg*zf_fg=1 then vkl_mo end
, case when zf_fg*stl_fg=1 then vkl_gj end
from (
    select base.*,
        (base.neo_fg * base.ums_ist) as ist_fil,
        (base.neo_fg * base.ums_kvj) as kvj_fil,
        (base.neo_fg * base.ums_plan) as plan_fil,
        sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id) as ist_reg,
        sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id) as kvj_reg,
        sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo) as ist_land,
        sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo) as kvj_land,
        
        nullif(base.neo_fg, 0) * safe_divide(((base.neo_fg*base.ums_ist) - (base.neo_fg*base.ums_plan)), (base.neo_fg*base.ums_plan)) as fil_mo,
        nullif(base.neo_fg*base.stl_fg, 0) * safe_divide((sum(base.bs_fg*base.neo_fg*base.stl_fg*base.ums_ist) over(partition by base.mandant_id, base.wrg_id, base.gj, base.wup_id) - sum(base.bs_fg*base.neo_fg*base.stl_fg*base.ums_plan) over(partition by base.mandant_id, base.wrg_id, base.gj, base.wup_id)), sum(base.bs_fg*base.neo_fg*base.stl_fg*base.ums_plan) over(partition by base.mandant_id, base.wrg_id, base.gj, base.wup_id)) as fil_gj,
        nullif(base.zf_fg, 0) * safe_divide((sum(base.neo_fg*base.zf_fg*base.ums_ist) over(partition by base.mandant_id, base.wrg_id, base.kjmo, base.vkl_id) - sum(base.neo_fg*base.zf_fg*base.ums_plan) over(partition by base.mandant_id, base.wrg_id, base.kjmo, base.vkl_id)), sum(base.neo_fg*base.zf_fg*base.ums_plan) over(partition by base.mandant_id, base.wrg_id, base.kjmo, base.vkl_id)) as vkl_mo,
        nullif(base.zf_fg*base.stl_fg, 0) * safe_divide((sum(base.bs_fg*base.neo_fg*base.zf_fg*base.stl_fg*base.ums_ist) over(partition by base.mandant_id, base.wrg_id, base.gj, base.vkl_id) - sum(base.bs_fg*base.neo_fg*base.zf_fg*base.stl_fg*base.ums_plan) over(partition by base.mandant_id, base.wrg_id, base.gj, base.vkl_id)), sum(base.bs_fg*base.neo_fg*base.zf_fg*base.stl_fg*base.ums_plan) over(partition by base.mandant_id, base.wrg_id, base.gj, base.vkl_id)) as vkl_gj
    from prep_sorting base
)

union all

-- vtr110
select mandant_id, sub.nb_id, sub.vs_id, sub.vkl_id, wup_id, wrg_id, sub.gj, kjmo, cast(110 as int64),
    sub1.ums_uf_ist, null, sub1.ums_uf_kvj, null, null, null,
    sum(sub1.ums_uf_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id), null,
    sum(sub1.ums_uf_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id), null,
    sum(sub1.ums_uf_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo), null,
    sum(sub1.ums_uf_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo), null,
    null, null, null, null, null, null, null, null
from monat_fakt_wup sub
left join monat_fakt_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr120
select sub.mandant_id, sub.nb_id, sub.vs_id, sub.vkl_id, sub.wup_id, sub.wrg_id, sub.gj, sub.kjmo, cast(120 as int64),
    sub1.ums_sa_ist, null, sub2.ums_sa_kvj, null, null, null,
    sum(sub1.ums_sa_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id), null,
    sum(sub2.ums_sa_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id), null,
    sum(sub1.ums_sa_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo), null,
    sum(sub2.ums_sa_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo), null,
    null, null, null, null, null, null, null, null
from monat_fakt_wup sub
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when bewart_id=1002 then umsatz_netto else 0 end) as ums_sa_ist from `kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum` group by 1,2,3,4) sub1 using (wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when bewart_id=1002 then umsatz_netto else 0 end) as ums_sa_kvj from `kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum` group by 1,2,3,4) sub2 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr125
select sub.mandant_id, sub.nb_id, sub.vs_id, sub.vkl_id, sub.wup_id, sub.wrg_id, sub.gj, sub.kjmo, cast(125 as int64),
    sub1.ums_sa_ist, sub1.ums_artb_ist, sub2.ums_sa_kvj, sub2.ums_artb_kvj, null, null,
    sum(sub1.ums_sa_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id),
    sum(sub1.ums_artb_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id),
    sum(sub2.ums_sa_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id),
    sum(sub2.ums_artb_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo, sub.vs_id),
    sum(sub1.ums_sa_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo),
    sum(sub1.ums_artb_ist) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo),
    sum(sub2.ums_sa_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo),
    sum(sub2.ums_artb_kvj) over (partition by sub.mandant_id, sub.wrg_id, sub.kjmo),
    null, null, null, null, null, null, null, null
from monat_fakt_wup sub
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(umsatz_netto) as ums_artb_ist, sum(case when bewart_id=1002 then umsatz_netto else 0 end) as ums_sa_ist from `kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum` group by 1,2,3,4) sub1 using (wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(umsatz_netto) as ums_artb_kvj, sum(case when bewart_id=1002 then umsatz_netto else 0 end) as ums_sa_kvj from `kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum` group by 1,2,3,4) sub2 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr140
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(140 as int64),
    sub1.mng_opf_ist, null, sub1.mng_opf_kvj, null, null, null,
    sum(sub1.mng_opf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.mng_opf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.mng_opf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub1.mng_opf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    null, null, null, null, null, null, null, null
from prep_sorting base
left join monat_fakt_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr160
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(160 as int64),
    base.knd_ist, null, base.knd_kvj, null, null, null,
    sum(base.knd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(base.knd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(base.knd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(base.knd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    null, null, null, null, null, null, null, null
from prep_sorting base

union all

-- vtr180
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(180 as int64),
    base.ums_ist, base.knd_ist, base.ums_kvj, base.knd_kvj, null, null,
    sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base

union all

-- vtr200
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(200 as int64),
    base.std_ist, null, base.std_kvj, null, base.std_plan, null,
    sum(base.std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(base.std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(base.std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(base.std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by (nullif(base.neo_fg,0)*((base.neo_fg*base.std_ist - ifnull(base.neo_fg*base.std_plan,0)) / nullif(base.neo_fg*base.std_plan,0))) desc nulls last) end,
    null, null, null, null, null, null, null 
from prep_sorting base

union all

-- vtr210
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(210 as int64),
    base.ums_ist, base.std_ist, base.ums_kvj, base.std_kvj, base.ums_plan, base.std_plan,
    sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by (nullif(base.neo_fg,0)*(safe_divide(base.ums_ist,base.std_ist) - safe_divide(base.ums_plan,base.std_plan))) desc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base

union all

-- vtr220
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(220 as int64),
    sub1.mng_opf_ist, base.std_ist, sub1.mng_opf_kvj, base.std_kvj, null, null,
    sum(sub1.mng_opf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.mng_opf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.mng_opf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.mng_opf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base
left join monat_fakt_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr240 
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(240 as int64),
    sub3.ums_pos_ist, sub3.kass_std_ist, sub4.ums_pos_kvj, sub4.kass_std_kvj, null, null,
    sum(sub3.ums_pos_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub3.kass_std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub4.ums_pos_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub4.kass_std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub3.ums_pos_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub3.kass_std_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub4.ums_pos_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub4.kass_std_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub3.ums_pos_ist, sub3.kass_std_ist) desc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when kasse_typ_id in (1) then umsatz_netto end) as ums_pos_ist, sum(case when kasse_typ_id in (1) then kassierzeit/3600.0 end) as kass_std_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse` k join `kfl_production_dbp_msi_view_vis.mv_kasse_typ_per` p using(mandant_id, wup_id, kasse_nr, dat) join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where kasse_typ_id in (1,8,9,10,11) group by 1,2,3,4) sub3 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when kasse_typ_id in (1) then umsatz_netto end) as ums_pos_kvj, sum(case when kasse_typ_id in (1) then kassierzeit/3600.0 end) as kass_std_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse` k join `kfl_production_dbp_msi_view_vis.mv_kasse_typ_per` p using(mandant_id, wup_id, kasse_nr, dat) join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where kasse_typ_id in (1,8,9,10,11) group by 1,2,3,4) sub4 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr250
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(250 as int64),
    sub3.art_anz_ist, sub3.scan_min_ist, sub4.art_anz_kvj, sub4.scan_min_kvj, null, null,
    sum(sub3.art_anz_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub3.scan_min_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub4.art_anz_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub4.scan_min_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub3.art_anz_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub3.scan_min_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub4.art_anz_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub4.scan_min_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub3.art_anz_ist, sub3.scan_min_ist) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when kasse_typ_id in (1) then anz_artikel end) as art_anz_ist, sum(case when kasse_typ_id in (1) then registrierzeit/60.0 end) as scan_min_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse` k join `kfl_production_dbp_msi_view_vis.mv_kasse_typ_per` p using(mandant_id, wup_id, kasse_nr, dat) join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where kasse_typ_id in (1,8,9,10,11) group by 1,2,3,4) sub3 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when kasse_typ_id in (1) then anz_artikel end) as art_anz_kvj, sum(case when kasse_typ_id in (1) then registrierzeit/60.0 end) as scan_min_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse` k join `kfl_production_dbp_msi_view_vis.mv_kasse_typ_per` p using(mandant_id, wup_id, kasse_nr, dat) join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where kasse_typ_id in (1,8,9,10,11) group by 1,2,3,4) sub4 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr270
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(270 as int64),
    base.kst_ist, null, base.kst_kvj, null, null, null,
    sum(base.kst_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(base.kst_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(base.kst_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(base.kst_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by (nullif(base.neo_fg,0)*(base.kst_ist - base.kst_kvj)) desc nulls last) end,
    null, null, null, null, null, null, null 
from prep_sorting base

union all

-- vtr275
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(275 as int64),
    base.kst_ist, base.ums_ist, base.kst_kvj, base.ums_kvj, null, null,
    sum(base.kst_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.kst_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.kst_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.kst_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(base.kst_ist, base.ums_ist) desc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base

union all

-- vtr300
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(300 as int64),
    sub1.abs_op_ist, null, sub1.abs_op_kvj, null, null, null,
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    null, null, null, null, null, null, null, null
from prep_sorting base
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr310
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(310 as int64),
    sub1.abs_op_ist, sub0.ums_ist, sub1.abs_op_kvj, sub0.ums_kvj, null, null,
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base
left join monat_fakt_wg sub0 using (wup_id, mandant_id, wrg_id, kjmo)
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr320
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(320 as int64),
    sub1.abs_uf_ist, sub0.ums_uf_ist, sub1.abs_uf_kvj, sub0.ums_uf_kvj, null, null,
    sum(sub1.abs_uf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_uf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_uf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_uf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_uf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_uf_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_uf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_uf_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base
left join monat_fakt_wg sub0 using (wup_id, mandant_id, wrg_id, kjmo)
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr340
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(340 as int64),
    sub1.abs_pa_ist, sub0.ums_ist, sub1.abs_pa_kvj, sub0.ums_kvj, null, null,
    sum(sub1.abs_pa_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_pa_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_pa_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_pa_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base
left join monat_fakt_wg sub0 using (wup_id, mandant_id, wrg_id, kjmo)
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr345
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(345 as int64),
    sub1.abs_pa_ist, sub1.abs_op_ist, sub1.abs_pa_kvj, sub1.abs_op_kvj, null, null,
    sum(sub1.abs_pa_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_pa_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_pa_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_pa_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by (safe_divide(sub1.abs_pa_ist, sub1.abs_op_ist) - safe_divide(sub1.abs_pa_kvj, sub1.abs_op_kvj)) desc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr360
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(360 as int64),
    sub1.abs_ta_ist, sub0.ums_ist, sub1.abs_ta_kvj, sub0.ums_kvj, null, null,
    sum(sub1.abs_ta_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_ta_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub0.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_ta_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_ta_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub0.ums_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base
left join monat_fakt_wg sub0 using (wup_id, mandant_id, wrg_id, kjmo)
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr365
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(365 as int64),
    sub1.abs_ta_ist, sub1.abs_op_ist, sub1.abs_ta_kvj, sub1.abs_op_kvj, null, null,
    sum(sub1.abs_ta_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_ta_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.abs_ta_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_op_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_ta_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.abs_op_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null
from prep_sorting base
left join tag_abschriften_wg sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr410
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(410 as int64),
    sub1.inv_wert_ist, sub1.inv_ums_ist, null, null, null, null,
    sum(sub1.inv_wert_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.inv_ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    null, null,
    sum(sub1.inv_wert_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.inv_ums_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null,
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub1.inv_wert_ist, sub1.inv_ums_ist) desc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, zeit.kjmo, sum(vis.inventur_wert_netto) as inv_wert_ist, sum(vis.inventur_ums_netto) as inv_ums_ist from `kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur` vis inner join `kfl_production_dbp_data.tag` zeit1 on zeit1.dat = vis.dat_plan_zaehlung inner join `kfl_production_dbp_data.monat` zeit on zeit.kjmo = zeit1.kjmo and zeit.akt_gj in (-1, 0) and zeit.akt_mo < 0 inner join `kfl_production_dbp_data.wup` wup on wup.wup_id = vis.wup_id and wup.mandant_id = vis.mandant_id where (wup.nb_id=0 or wup.wup_id in (0,2,22,28,43,46,124,8980,8987,8991,100000,100002,100022,100028,100043,100046,100124)) and wup.dat_eroeffnung < date '2090-12-31' and (extract(year from wup.dat_bis) + case when extract(month from wup.dat_bis) < 3 then -1 else 0 end) > (zeit.gj + 1) and vis.abt_invart_id in (50) group by 1,2,3,4,5) sub1 using (wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr510
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(510 as int64),
    sub1.w_kasse_ist, null, sub2.w_kasse_kvj, null, null, null,
    sum(sub1.w_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub2.w_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.w_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub2.w_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by sub1.w_kasse_ist asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id = 92 then vk_menge_kuga else 0 end) as w_kasse_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id = 92 then vk_menge_kuga else 0 end) as w_kasse_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr515
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(515 as int64),
    sub1.w_kasse_ist, base.knd_10t_ist, sub2.w_kasse_kvj, base.knd_10t_kvj, null, null,
    sum(sub1.w_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub2.w_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.w_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub2.w_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub1.w_kasse_ist, base.knd_10t_ist) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id = 92 then vk_menge_kuga else 0 end) as w_kasse_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id = 92 then vk_menge_kuga else 0 end) as w_kasse_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr520
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(520 as int64),
    sub1.w_theke_ist, null, sub2.w_theke_kvj, null, null, null,
    sum(sub1.w_theke_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub2.w_theke_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.w_theke_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub2.w_theke_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by sub1.w_theke_ist asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id = 91 then vk_menge_kuga else 0 end) as w_theke_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id = 91 then vk_menge_kuga else 0 end) as w_theke_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr525
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(525 as int64),
    sub1.w_theke_ist, base.knd_10t_ist, sub2.w_theke_kvj, base.knd_10t_kvj, null, null,
    sum(sub1.w_theke_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub2.w_theke_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.w_theke_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub2.w_theke_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub1.w_theke_ist, base.knd_10t_ist) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id = 91 then vk_menge_kuga else 0 end) as w_theke_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id = 91 then vk_menge_kuga else 0 end) as w_theke_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr530
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(530 as int64),
    sub1.anz_mhd_ist, null, sub2.anz_mhd_kvj, null, null, null,
    sum(sub1.anz_mhd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub2.anz_mhd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.anz_mhd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub2.anz_mhd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by sub1.anz_mhd_ist asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id = 93 then vk_menge_kuga else 0 end) as anz_mhd_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id = 93 then vk_menge_kuga else 0 end) as anz_mhd_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr535
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(535 as int64),
    sub1.anz_mhd_ist, base.knd_10t_ist, sub2.anz_mhd_kvj, base.knd_10t_kvj, null, null,
    sum(sub1.anz_mhd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub2.anz_mhd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.anz_mhd_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub2.anz_mhd_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub1.anz_mhd_ist, base.knd_10t_ist) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id = 93 then vk_menge_kuga else 0 end) as anz_mhd_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id = 93 then vk_menge_kuga else 0 end) as anz_mhd_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr540
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(540 as int64),
    sub1.f_preis_ist, null, sub2.f_preis_kvj, null, null, null,
    sum(sub1.f_preis_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub2.f_preis_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.f_preis_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub2.f_preis_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by sub1.f_preis_ist asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id in(12,19) then 1 else 0 end) as f_preis_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id in(12,19) then 1 else 0 end) as f_preis_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr545
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(545 as int64),
    sub1.f_preis_ist, base.knd_10t_ist, sub2.f_preis_kvj, base.knd_10t_kvj, null, null,
    sum(sub1.f_preis_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub2.f_preis_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.f_preis_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub2.f_preis_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(base.knd_10t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub1.f_preis_ist, base.knd_10t_ist) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id in(12,19) then 1 else 0 end) as f_preis_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id in(12,19) then 1 else 0 end) as f_preis_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr550
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(550 as int64),
    sub1.f_kasse_ist, null, sub2.f_kasse_kvj, null, null, null,
    sum(sub1.f_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub2.f_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null,
    sum(sub1.f_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    sum(sub2.f_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null,
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by sub1.f_kasse_ist asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id in(13,14) then 1 else 0 end) as f_kasse_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id in(13,14) then 1 else 0 end) as f_kasse_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr555
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(555 as int64),
    sub1.f_kasse_ist, sub3.art_100t_ist, sub2.f_kasse_kvj, sub4.art_100t_kvj, null, null,
    sum(sub1.f_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub3.art_100t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub2.f_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub4.art_100t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.f_kasse_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub3.art_100t_ist) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub2.f_kasse_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub4.art_100t_kvj) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    case when base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide(sub1.f_kasse_ist, sub3.art_100t_ist) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when reklamationsgrund_id in(13,14) then 1 else 0 end) as f_kasse_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub1 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when reklamationsgrund_id in(13,14) then 1 else 0 end) as f_kasse_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art` v join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where reklamationsgrund_id in(12,13,14,19,91,92,93) group by 1,2,3,4) sub2 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo, sum(case when kasse_typ_id in (1) then anz_artikel end)/100000.0 as art_100t_ist from `kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse` k join `kfl_production_dbp_msi_view_vis.mv_kasse_typ_per` p using(mandant_id, wup_id, kasse_nr, dat) join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where kasse_typ_id in (1,8,9,10,11) group by 1,2,3,4) sub3 using(wup_id, mandant_id, wrg_id, kjmo)
left join (select mandant_id, wup_id, wrg_id, kjmo-100 as kjmo, sum(case when kasse_typ_id in (1) then anz_artikel end)/100000.0 as art_100t_kvj from `kfl_production_dbp_msi_view_vis.mv_vis_tag_kasse` k join `kfl_production_dbp_msi_view_vis.mv_kasse_typ_per` p using(mandant_id, wup_id, kasse_nr, dat) join `kfl_production_dbp_data.tag` t using(dat) join `kfl_production_dbp_data.monat` m using(kjmo) where kasse_typ_id in (1,8,9,10,11) group by 1,2,3,4) sub4 using(wup_id, mandant_id, wrg_id, kjmo)

union all

-- vtr710
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(710 as int64),
    (sub1.best_vor - sub1.best_kor), (sub1.best_vor + sub1.best_man), null, null, null, null,
    sum(sub1.best_vor - sub1.best_kor) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.best_vor + sub1.best_man) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    null, null,
    sum(sub1.best_vor - sub1.best_kor) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.best_vor + sub1.best_man) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null,
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide((sub1.best_vor - sub1.best_kor), (sub1.best_vor + sub1.best_man)) desc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join (select mandant_id, nb_id, wup_id, kjmo, sum(case when status not in ('0b','0n') then 1 else 0 end) as best_vor, sum(case when status in ('0b') then 1 else 0 end) as best_man, sum(case when status in ('v0','v-','v+') then 1 else 0 end) as best_kor from `kfl_production_dbp_msi_view_vis.mv_bsch_bestvor_det` v join `kfl_production_dbp_data.tag` t on t.dat=v.dat_plan join `kfl_production_dbp_data.monat` m using(kjmo) where status not in ('0n') group by 1,2,3,4) sub1 using(wup_id, mandant_id, kjmo)

union all

-- vtr730
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(730 as int64),
    sub1.auftrag, null, null, null, null, null,
    sum(sub1.auftrag) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null, null, null,
    sum(sub1.auftrag) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null, null, null,
    null, null, null, null, null, null, null, null
from prep_sorting base
left join zaehl_auftrag sub1 using (wup_id, mandant_id, kjmo)

union all

-- vtr732
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(732 as int64),
    sub1.gezaehlt, null, null, null, null, null,
    sum(sub1.gezaehlt) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id), null, null, null,
    sum(sub1.gezaehlt) over (partition by base.mandant_id, base.wrg_id, base.kjmo), null, null, null,
    null, null, null, null, null, null, null, null
from prep_sorting base
left join zaehl_auftrag sub1 using (wup_id, mandant_id, kjmo)

union all

-- vtr735
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(735 as int64),
    sub1.gezaehlt, sub1.auftrag, null, null, null, null,
    sum(sub1.gezaehlt) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.auftrag) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    null, null,
    sum(sub1.gezaehlt) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.auftrag) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null, null, null
from prep_sorting base
left join zaehl_auftrag sub1 using (wup_id, mandant_id, kjmo)

union all

-- vtr750
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(750 as int64),
    sub1.null_best, sub1.auto_dispo, null, null, null, null,
    sum(sub1.null_best) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.auto_dispo) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    null, null,
    sum(sub1.null_best) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.auto_dispo) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null, null, null
from prep_sorting base
left join tag_fwws_wg sub1 using (wup_id, mandant_id, kjmo)

union all

-- vtr752
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(752 as int64),
    sub1.minus_best, sub1.auto_dispo, null, null, null, null,
    sum(sub1.minus_best) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.auto_dispo) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    null, null,
    sum(sub1.minus_best) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.auto_dispo) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null, null, null, null, null, null, null, null, null
from prep_sorting base
left join tag_fwws_wg sub1 using (wup_id, mandant_id, kjmo)

union all

-- vtr755
select base.mandant_id, base.nb_id, base.vs_id, base.vkl_id, base.wup_id, base.wrg_id, base.gj, base.kjmo, cast(755 as int64),
    (sub1.null_best + sub1.minus_best), sub1.auto_dispo, null, null, null, null,
    sum(sub1.null_best + sub1.minus_best) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    sum(sub1.auto_dispo) over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id),
    null, null,
    sum(sub1.null_best + sub1.minus_best) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    sum(sub1.auto_dispo) over (partition by base.mandant_id, base.wrg_id, base.kjmo),
    null, null,
    case when base.bs_fg*base.neo_fg=1 then dense_rank() over (partition by base.mandant_id, base.wrg_id, base.kjmo, base.vs_id order by safe_divide((sub1.null_best + sub1.minus_best), sub1.auto_dispo) asc nulls last) end,
    null, null, null, null, null, null, null
from prep_sorting base
left join tag_fwws_wg sub1 using (wup_id, mandant_id, kjmo);