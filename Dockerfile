FROM nginx:1.13-alpine
MAINTAINER Marc Tanis <marc@blendimc.com>
EXPOSE 8080

WORKDIR /var/www

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Set craft cms version
ENV CRAFT_VERSION=2.6 CRAFT_BUILD=3009

ENV CRAFT_ZIP=Craft-$CRAFT_VERSION.$CRAFT_BUILD.zip

# Download the latest Craft (https://craftcms.com/support/download-previous-versions)
ADD https://download.buildwithcraft.com/craft/$CRAFT_VERSION/$CRAFT_VERSION.$CRAFT_BUILD/$CRAFT_ZIP /tmp/$CRAFT_ZIP

# Extract craft to webroot & remove default template files
RUN unzip -qqo /tmp/$CRAFT_ZIP 'craft/*' -d /var/www/ && \
    unzip -qqo /tmp/$CRAFT_ZIP 'public/index.php' -d /var/www/ && \
        rm -rf /var/www/craft/templates/* && \
        rm /tmp/$CRAFT_ZIP

