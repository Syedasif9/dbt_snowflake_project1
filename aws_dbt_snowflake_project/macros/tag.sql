{% macro tag(col) %}
    case 
        when {{ col }} < 100 then 'low'
        when {{ col }} <200 then 'med'
        else 'high'
    end

{% endmacro %}