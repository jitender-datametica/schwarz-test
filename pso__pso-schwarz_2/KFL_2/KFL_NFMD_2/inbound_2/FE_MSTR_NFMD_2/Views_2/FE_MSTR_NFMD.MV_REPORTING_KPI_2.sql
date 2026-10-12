create or replace view FE_MSTR_NFMD.MV_REPORTING_KPI_2 as (     
with base as (
    select 
    v01.promo_week,
    v01.aktion_id, 
    v01.mandant_id,
    v01.art_id, 
    v01.curve_week,
    v01.wup_id, 
    v01.WG_BEZ,
    v01.wup_region, 
    v01.stock_initial, 
    v01.stock_initial - v01.CUMULATED_SALES as aktueller_bestand,
    v01.sales_2 as Absatz, 
    v01.CUMULATED_SALES as absatz_total, 
    v01.sell_ratio as avq, 
    v01.revenue,
    sum(v01.revenue) over (partition by v01.promo_week, v01.mandant_id, v01.art_id, v01.wup_id, v01.aktion_id, v01.CURRENCY  ) as Umsatz_total,
    sum(v01.sales_2) over (partition by v01.promo_week, v01.mandant_id, v01.art_id, v01.wup_id, v01.aktion_id, v01.CURRENCY  ) as akt_absatz_total,

    v01.vk_aktion_brutto, 
    v01.CURRENCY,
    v03.JF_COMMENT,
    v04.akt_wo, -- preufen welche Woche_2 
    to_Date(substr(v01.MODEL_DATE,1,8),'yyyymmdd') as model_date_format
    from  CORE.SRC_HDP_MD_CURVES_MASTER_REPORTING_2 v01
    join CORE.TS_ID30_MSI_FINAL_SUBMIT_2 v02
    on v01.aktion_id = v02.aktion_id
    and v01.calendar_week = v02.week_id 
    and v01.calendar_year = v02.year_id 
    and v01.art_id = v02.sku_id 
    and v01.mandant_id = v02.mandant_id
    and v02.markdown_decision =  0  
    left join FE_MSTR_NFMD.MV_ID30_LATEST_COMM_WB_2 v03
    on v01.aktion_id = v03.aktion_id
    and v01.calendar_year = v03.year_id 
    and v01.calendar_week = v03.week_id 
    and v01.art_id = v03.sku_id 
    and v01.mandant_id = v03.mandant_id
    and length(trim(v03.jf_comment)) >0
    inner join FE_MSTR_NFMD.MV_LOOKUP_DATES_2 v04
    on v04.KJWO = v01.promo_week
    and v04.akt_wo <= 0
  where v01.stock_initial > 0

), week_8 as (
    select distinct
    v01.promo_week,
    v01.aktion_id, 
    v01.mandant_id,
    v01.art_id, 
    v01.curve_week,
    v01.wup_id, 
    aktueller_bestand as Bestand_8woche,
    Absatz_total, 
    Umsatz_total,    
    v01.vk_aktion_brutto, 
    --Bestand_8woche *  v01.vk_aktion_brutto as Restmenge,
    v01.CURRENCY
    from base v01
    where v01.curve_week = 8 and v01.Absatz is not null 
), week_1 as (
    select distinct
    v01.promo_week, 
    v01.aktion_id, 
    v01.mandant_id,
    v01.art_id, 
    v01.curve_week,
    v01.wup_id, 
    v01.Absatz as absatz_1woche, 
    v01.revenue as umsatz_1woche,
    v01.CURRENCY
    from base v01
    /*join week_8 v02
    on v01.promo_week = v02.promo_week
        and v01.aktion_id = v02.aktion_id
        and v01.mandant_id = v02.mandant_id
        and v01.art_id = v02.art_id
        and v01.wup_id = v02.wup_id
        and v01.CURRENCY = v02.CURRENCY*/
    where v01.curve_week = 1 
), submit_table_base as (
    Select distinct 
    year_id || to_char(cast(week_id AS NUMBER), 'FM00') as promo_week,
    mandant_id,
    aktion_id,
    sku_id, 
    wup_id,
    submitted_price,
    valid_from_date,
    dense_rank() over (partition by year_id, week_id, mandant_id, aktion_id, sku_id,wup_id order by valid_from_date asc) as markdown
    from 
    CORE.TS_ID40_FINAL_SUBMIT_2
), submit_table_md as (
    Select distinct 
    promo_week,
    mandant_id,
    aktion_id,
    sku_id, 
    wup_id,
    max(markdown) AS Anzahl_Markdown 
    from submit_table_base 
  group by promo_week,
    mandant_id,
    aktion_id,
    sku_id, 
    wup_id
), submit_table_1md as (
    Select distinct 
    promo_week,
    mandant_id,
    aktion_id,
    sku_id, 
    wup_id,
    submitted_price,
    valid_from_date
    from submit_table_base
    where markdown = '1'
), submit_table_2md as (
    Select distinct 
    promo_week,
    mandant_id,
    aktion_id,
    sku_id, 
    wup_id,
    submitted_price,
    valid_from_date
    from submit_table_base
    where markdown = '2'
) 

Select distinct
    base.promo_week, 
    base.mandant_id,
    base.aktion_id,
    base.art_id, 
    td_art.kl_art_id,
    base.wup_id, 
    base.WG_BEZ,
    base.wup_region, 
    base.CURRENCY,
    base.akt_wo, 
    base.model_date_format,
    CASE WHEN base.akt_wo between -8 and 0 then 'laufend'
    WHEN base.akt_wo < -8 and week_8.absatz_total is null then 'abgebrochen'
    ELSE 'abgeschlossen' END 
    AS CURVE_STATUS,
  
    base.JF_COMMENT,
    base.stock_initial as initialer_bestand,
    base.vk_aktion_brutto as initialer_VK_Brutto,
    base.vk_aktion_brutto / 1.19 as initialer_VK_netto,
    base.akt_absatz_total as absatz_total,
    week_1.absatz_1woche as Absatz_W1,
    week_1.umsatz_1woche as Umsatz_W1,
    week_1.umsatz_1woche / 1.19 as Umsatz_W1_netto,
    week_8.Bestand_8woche as Endbestand_W8,
    week_8.Bestand_8woche * (week_8.vk_aktion_brutto / 1.19) as Restmenge_EUR,
    base.Umsatz_total as Umsatz_total_brutto,
    base.Umsatz_total / 1.19 as Umsatz_total_netto,
  
    COALESCE(submit_table_md.Anzahl_Markdown, 0) as Anzahl_Markdown,
    submit_table_1md.submitted_price as "1_Reduzierung",
    submit_table_2md.submitted_price as "2_Reduzierung",
    COALESCE(submit_table_2md.submitted_price,submit_table_1md.submitted_price,base.vk_aktion_brutto)   as aktueller_VK,
    case when submit_table_md.Anzahl_Markdown is not null  then 1 - (aktueller_VK / base.vk_aktion_brutto) else 0 end  as gegebener_rabatt,
    
    round ((initialer_VK_netto * base.akt_absatz_total),2) - round(Umsatz_total_netto,2) as preisabschrift,
    week_8.Bestand_8woche * ( (base.vk_aktion_brutto - aktueller_VK) / 1.19 ) as totalabschrift, 
    --preisabschrift + totalabschrift as abschrift_gesamt_EUR,
    preisabschrift + Restmenge_EUR as abschrift_gesamt_EUR,
    base.stock_initial * initialer_VK_netto as initialer_Warenwert
    
    
 
from base
  JOIN CORE.SRC_TERADATA_MASTER_DATA_ART_2 td_art
          on base.ART_ID = td_art.art_id
          and base.mandant_id = td_art.mandant_id

left JOIN week_8
on base.promo_week = week_8.promo_week
    and base.aktion_id = week_8.aktion_id
    and base.mandant_id = week_8.mandant_id
    and base.art_id = week_8.art_id
    and base.wup_id = week_8.wup_id
    and base.CURRENCY = week_8.CURRENCY
left JOIN week_1
on base.promo_week = week_1.promo_week
    and base.aktion_id = week_1.aktion_id
    and base.mandant_id = week_1.mandant_id
    and base.art_id = week_1.art_id
    and base.wup_id = week_1.wup_id
    and base.CURRENCY = week_1.CURRENCY
left join submit_table_md
on base.promo_week = submit_table_md.promo_week
    and base.aktion_id = submit_table_md.aktion_id
    and base.mandant_id = submit_table_md.mandant_id
    and base.art_id = submit_table_md.SKU_ID
    and base.wup_id = submit_table_md.wup_id
left join submit_table_1md
on submit_table_md.promo_week = submit_table_1md.promo_week
    and submit_table_md.aktion_id = submit_table_1md.aktion_id
    and submit_table_md.mandant_id = submit_table_1md.mandant_id
    and submit_table_md.SKU_ID = submit_table_1md.SKU_ID
    and submit_table_md.wup_id = submit_table_1md.wup_id
left join submit_table_2md
on submit_table_md.promo_week = submit_table_2md.promo_week
    and submit_table_md.aktion_id = submit_table_2md.aktion_id
    and submit_table_md.mandant_id = submit_table_2md.mandant_id
    and submit_table_md.SKU_ID = submit_table_2md.SKU_ID
    and submit_table_md.wup_id = submit_table_2md.wup_id ) ;