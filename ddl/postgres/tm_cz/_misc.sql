--
-- Name: median(anyelement); Type: AGGREGATE; Schema: tm_cz; Owner: -
--
CREATE AGGREGATE median(anyelement) (
    SFUNC = array_append,
    STYPE = anyarray,
    INITCOND = '{}',
    FINALFUNC = _final_median
);


SET default_with_oids = false;

--
-- Name: czv_pivot_sample_categories; Type: VIEW; Schema: tm_cz; Owner: -
--
CREATE VIEW czv_pivot_sample_categories AS
 SELECT x.trial_cd, 
    x.sample_cd AS sample_id, 
    x.trial_name, 
    COALESCE(x.pathology, 'Not Applicable'::text) AS pathology, 
    COALESCE(x.race, 'Not Applicable'::text) AS race, 
    COALESCE(x.tissue_type, 'Not Applicable'::text) AS tissue_type, 
    COALESCE(x.gender, 'Not Applicable'::text) AS gender, 
    COALESCE(x.biomarker, 'Not Applicable'::text) AS biomarker, 
    COALESCE(x.access_type, 'Not Applicable'::text) AS access_type, 
    COALESCE(x.institution, 'Not Applicable'::text) AS institution, 
    COALESCE(x.program_initiative, 'Not Applicable'::text) AS program_initiative, 
    COALESCE(x.organism, 'Not Applicable'::text) AS organism
   FROM ( SELECT s.trial_cd, 
            s.sample_cd, 
            f.c_name AS trial_name, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'PATHOLOGY'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS pathology, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'RACE'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS race, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'TISSUE_TYPE'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS tissue_type, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'GENDER'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS gender, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'BIOMARKER'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS biomarker, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'ACCESS'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS access_type, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'INSTITUTION'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS institution, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'PROGRAM/INITIATIVE'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS program_initiative, 
            max((
                CASE
                    WHEN ((s.category_cd)::text = 'ORGANISM'::text) THEN s.category_value
                    ELSE NULL::character varying
                END)::text) AS organism
           FROM tm_lz.lz_src_sample_categories s, 
            i2b2metadata.i2b2 f
          WHERE (((s.trial_cd)::text = (f.sourcesystem_cd)::text) AND (f.c_hlevel = ( SELECT min(x_1.c_hlevel) AS min
                   FROM i2b2metadata.i2b2 x_1
                  WHERE ((f.sourcesystem_cd)::text = (x_1.sourcesystem_cd)::text))))
          GROUP BY s.trial_cd, s.sample_cd, f.c_name) x;

--
-- Name: emt_temp_seq; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE emt_temp_seq
    START WITH 11621
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;

--
-- Name: rtqalimits_testid_seq; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE rtqalimits_testid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;

--
-- Name: rtqastatslist_testid_seq; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE rtqastatslist_testid_seq
    START WITH 80000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;

--
-- Name: seq_child_rollup_id; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_child_rollup_id
    START WITH 1681
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;

--
-- Name: seq_cz_data; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_data
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 2;

--
-- Name: seq_cz_data_file; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_data_file
    START WITH 6
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 2;

--
-- Name: seq_cz_dw_version_id; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_dw_version_id
    START WITH 41
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 2;

--
-- Name: seq_cz_job_id; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_job_id
    START WITH 413
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 20;

--
-- Name: seq_cz_job_message; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_job_message
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 2;

--
-- Name: seq_cz_test; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_test
    START WITH 8259
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 2;

--
-- Name: seq_cz_test_category; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_cz_test_category
    START WITH 5
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 2;

--
-- Name: seq_region_id; Type: SEQUENCE; Schema: tm_cz; Owner: -
--
CREATE SEQUENCE seq_region_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

