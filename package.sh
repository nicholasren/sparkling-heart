#!/usr/bin/env bash
elm-app build && \
tar -C build -czvf app.tgz . && \
mv app.tgz /tmp
