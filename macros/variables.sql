{% macro learn_variables() %}
    
    {% set your_name_jinja = "omara" %}
    {{ log("Hello" ~ your_name_jinja, info=true)}}

    {{ log("Hello DBT users" ~ var("user_name","No user name is set !!") ~ "!" , info=true)}}

{% endmacro %}