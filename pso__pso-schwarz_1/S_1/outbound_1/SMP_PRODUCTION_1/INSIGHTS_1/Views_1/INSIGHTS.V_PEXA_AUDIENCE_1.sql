CREATE OR REPLACE VIEW smp_production_insights.v_pexa_audience_1 (division_id, country_id, audience_category,
audience_name, audience_type, audience_id, universe_id) AS SELECT division_id,
 country_id,
 INITCAP(REPLACE(universe_category, '-', ' ')) AS audience_category,
 INITCAP(REPLACE(universe_name, '-', ' ')) AS audience_name,
 universe_type_id AS audience_type,
 universe_id_opt AS audience_id,
 universe_id
FROM smp_production_core_rel.t_universe_1
WHERE source_system_id = 'PEXA';