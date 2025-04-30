# Use a imagem base do Ruby
ARG RUBY_VERSION=3.4.1
FROM ruby:$RUBY_VERSION-slim AS base

# Configurar o diretório de trabalho
WORKDIR /rails

# Instalar dependências essenciais
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    curl \
    libjemalloc2 \
    libvips \
    sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Configurar variáveis de ambiente
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Estágio de build para reduzir o tamanho da imagem final
FROM base AS build

# Instalar dependências de build
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y git pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copiar Gemfile e instalar gems
COPY Gemfile Gemfile.lock ./ 
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copiar o código da aplicação
COPY . .

# Pré-compilar o código do bootsnap para inicialização mais rápida
RUN bundle exec bootsnap precompile app/ lib/

# Ajustar permissões dos arquivos binários
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

# Estágio final para produção
FROM base

# Copiar artefatos do estágio de build
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Garantir que os diretórios necessários existam e configurar permissões
RUN mkdir -p storage tmp && \
    groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

# Copiar o script de inicialização
COPY bin/docker-entrypoint /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

# Definir o usuário não-root após ajustar permissões
USER 1000:1000

# Configurar o entrypoint para preparar o banco de dados e iniciar o servidor
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

# Expor a porta e definir o comando padrão
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]