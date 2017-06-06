FROM gehlenborglab/higlass

COPY on_startup.py /home/higlass/projects/higlass-server
COPY input.json $HIGLASS_SERVER_BASE_DIR

# Append to the supervisord.conf and set the priority of `on_startup.py` to
# be greater than the default of `999` so that it starts up last
RUN ( echo ""; \
      echo "[program:on_startup]"; \
      echo "command = python /home/higlass/projects/higlass-server/on_startup.py"; \
      echo "priority = 1000"; ) \
    >> supervisord.conf

# We want higlass to access the default viewconf relative to our current container's url
RUN sed -i 's/"#higlass","\/api/"#higlass","\.\/api/g' \
/home/higlass/projects/higlass-website/assets/scripts/hg-launcher.js

ENV DJANGO_SETTINGS_MODULE="higlass_server.settings"
