require_relative 'base'
require_relative 'endpoint_template'
module Taric
  module Operation
    module LolStaticData
      include Taric::Operation::Base

      BASE_STATIC_URL = "https://{host}/lol/static-data/v3"

      STATIC_CHAMPIONS =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/champions{?api_key,dataById,champListData,locale,version}")
      STATIC_CHAMPION =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/champions/{id}{?api_key,champData,locale,version}")
      STATIC_ITEMS =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/items{?api_key,itemListData,locale,version}")
      STATIC_ITEM =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/items/{id}{?api_key,itemData,locale,version}")
      STATIC_LANGUAGE_STRINGS =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/language-strings{?api_key,locale,version}")
      STATIC_LANGUAGES =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/languages{?api_key}")
      STATIC_MAP =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/maps{?api_key,locale,version}")
      STATIC_MASTERIES =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/masteries{?api_key,masteryListData,locale,version}")
      STATIC_MASTERY =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/masteries/{id}{?api_key,masteryData,locale,version}")
      STATIC_PROFILE_ICONS =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/profile-icons{?api_key,locale,version}")
      STATIC_REALM =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/realms{?api_key}")
      STATIC_RUNES =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/runes{?api_key,runeListData,locale,version}")
      STATIC_RUNE =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/runes/{id}{?api_key,runeData,locale,version}")
      STATIC_SUMMONER_SPELLS =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/summoner-spells{?api_key,spellData,locale,version}")
      STATIC_SUMMONER_SPELL =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/summoner-spells/{id}{?api_key,spellData,locale,version}")
      STATIC_VERSIONS =  EndpointTemplate.new(template_url: "#{BASE_STATIC_URL}/versions{?api_key}")

      CHAMP_DATA_OPTIONS = [
          'all'.freeze,
          'allytips'.freeze,
          'altimages'.freeze,
          'blurb'.freeze,
          'enemytips'.freeze,
          'image'.freeze,
          'info'.freeze,
          'lore'.freeze,
          'partype'.freeze,
          'passive'.freeze,
          'recommended'.freeze,
          'skins'.freeze,
          'stats'.freeze,
          'tags'.freeze
      ]

      ITEM_DATA_OPTIONS = [
          'all'.freeze,
          'colloq'.freeze,
          'consumeOnFull'.freeze,
          'consumed'.freeze,
          'depth'.freeze,
          'from'.freeze,
          'gold'.freeze,
          'groups'.freeze,
          'hideFromAll'.freeze,
          'image'.freeze,
          'inStore'.freeze,
          'into'.freeze,
          'maps'.freeze,
          'requiredChampion'.freeze,
          'sanitizedDescription'.freeze,
          'specialRecipe'.freeze,
          'stacks'.freeze,
          'stats'.freeze,
          'tags'.freeze,
          'tree'.freeze
      ].freeze

      MASTERY_DATA_OPTIONS = [
          'all'.freeze,
          'image'.freeze,
          'masteryTree'.freeze,
          'prereq'.freeze,
          'ranks'.freeze,
          'sanitizedDescription'.freeze
      ].freeze

      SPELL_DATA_OPTIONS = [
          'all'.freeze,
          'cooldown'.freeze,
          'cooldownBurn'.freeze,
          'cost'.freeze,
          'costType'.freeze,
          'effect'.freeze,
          'effectBurn'.freeze,
          'image'.freeze,
          'key'.freeze,
          'leveltip'.freeze,
          'maxrank'.freeze,
          'modes'.freeze,
          'range'.freeze,
          'rangeBurn'.freeze,
          'resource'.freeze,
          'sanitizedDescription'.freeze,
          'sanitizedTooltip'.freeze,
          'tooltip'.freeze,
          'vars'.freeze
      ].freeze

      # locales mapped to languages
      LOCALE = {
          bg_BG: 'Bulgarian (Bulgaria)',
          cs_CZ: 'Czech (Czech Republic)',
          de_DE: 'German (Germany)',
          el_GR: 'Greek (Greece)',
          en_AU: 'English (Australia)',
          en_GB: 'English (United Kingdom)',
          en_PH: 'English (Republic of the Philippines)',
          en_PL: 'English (Poland)',
          en_SG: 'English (Singapore)',
          en_US: 'English (United States)',
          es_AR: 'Spanish (Argentina)',
          es_ES: 'Spanish (Spain)',
          es_MX: 'Spanish (Mexico)',
          fr_FR: 'French (France)',
          hu_HU: 'Hungarian (Hungary)',
          id_ID: 'Indonesian (Indonesia)',
          it_IT: 'Italian (Italy)',
          ja_JP: 'Japanese (Japan)',
          ko_KR: 'Korean (Korea)',
          nl_NL: 'Dutch (Netherlands)',
          ms_MY: 'Malay (Malaysia)',
          pl_PL: 'Polish (Poland)',
          pt_BR: 'Portuguese (Brazil)',
          pt_PT: 'Portuguese (Portugal)',
          ro_RO: 'Romanian (Romania)',
          ru_RU: 'Russian (Russia)',
          th_TH: 'Thai (Thailand)',
          tr_TR: 'Turkish (Turkey)',
          vn_VN: 'Vietnamese (Viet Nam)',
          zh_CN: 'Chinese (China)',
          zh_MY: 'Chinese (Malaysia)',
          zh_TW: 'Chinese (Taiwan)'
      }

      LOCALE_KEYS = LOCALE.keys

      # Static data for champions
      #
      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getChampionList
      # @param data_by_id [Boolean] optional, if true, champion data keyed to IDs
      # @param champ_list_data [String] optional, filter from [CHAMP_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static champion data
      #
      # @example
      #   # Defaults
      #   champions = client.static_champions
      #   # Mapped by IDs
      #   champions = client.static_champions(data_by_id: true)
      def static_champions(data_by_id: nil, locale: nil, champ_list_data: nil, version: nil)
        response_for STATIC_CHAMPIONS, {locale: locale, dataById: data_by_id, champListData: champ_list_data, version: version}
      end

      # Static data for champion by id
      #
      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getChampionById
      # @param id [Fixnum] id of champion
      # @param champ_data [String] optional, filter from [CHAMP_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static champion data
      #
      # @example
      #   champions = client.static_champions(id: 44)
      def static_champion(id:, champ_data: nil, locale: nil, version: nil)
        response_for STATIC_CHAMPION, {id: id, champData: champ_data, locale: locale, version: version}
      end

      # Static data for items
      #
      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getItemList
      # @param item_list_data [String] optional, filter from [ITEM_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static item data
      #
      # @example
      #   # Defaults
      #   champions = client.static_items
      def static_items(item_list_data: nil, locale: nil, version: nil)
        response_for STATIC_ITEMS, {itemListData: item_list_data, locale: locale, version: version}
      end

      # Static data for item by id
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3319
      # @param id [Fixnum] id of item
      # @param item_data_option [String] optional, filter from [ITEM_DATA_OPTIONS]
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      #
      # @return [Hash] of static item data for id
      #
      # @example
      #   item = client.static_item(id: 2049)
      def static_item(id:, item_data: nil, locale: nil, version: nil)
        response_for STATIC_ITEM, {id: id, itemData: item_data, locale: locale, version: version}
      end

      # Returns [Hash] of language string data.
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3316
      # @param locale [Symbol] optional, results will be in locale [LOCALE], or default for region if nil
      # @param version [String] optional, enforces version of static data, or latest if nil
      # @return [Hash] of language string data
      # @example
      #   language_strings = client.static_language_strings
      def static_language_strings(locale: nil, version: nil)
        response_for STATIC_LANGUAGE_STRINGS, {locale: locale, version: version}
      end

      # Returns [Array] of languages.
      #
      # @see https://developer.riotgames.com/api/methods#!/968/3324
      # @return [Array] of languages
      # @example
      #   languages = client.static_languages
      def static_languages
        response_for STATIC_LANGUAGES
      end

      # Maps available.
      # @see https://developer.riotgames.com/api/methods#!/968/3328
      # @param locale [String] filter by locale
      # @param version [String] patch version
      # @return [Hash] of maps available.
      def static_maps(locale: nil, version: nil)
        response_for STATIC_MAP, {locale: locale, version: version}
      end

      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getMasteryList
      def static_masteries(mastery_list_data: nil, locale: nil, version: nil)
        response_for STATIC_MASTERIES, {masteryListData: mastery_list_data, locale: locale, version: version}
      end

      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getMasteryById
      def static_mastery(id:, mastery_data: nil, locale: nil, version: nil)
        response_for STATIC_MASTERY, {id: id, masteryData: mastery_data, locale:locale, version: version}
      end

      # @see https://developer.riotgames.com/api/methods#!/968/3325
      def static_profile_icons(locale: nil, version: nil)
        response_for STATIC_PROFILE_ICONS, {locale: locale, version: version}
      end

      # @see https://developer.riotgames.com/api/methods#!/968/3325
      def static_realms
        response_for STATIC_REALM
      end

      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getRuneList
      def static_runes(rune_list_data: nil, locale: nil, version: nil)
        response_for STATIC_RUNES, {runeListData: rune_list_data, locale: locale, version: version}
      end

      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getRuneById
      def static_rune(id:, rune_data: nil, locale: nil, version: nil)
        response_for STATIC_RUNE, {id: id, runeData: rune_data, locale: locale, version: version}
      end

      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getSummonerSpellList
      def static_summoner_spells(spell_list_data: nil, locale: nil, version: nil, data_by_id: nil)
        response_for STATIC_SUMMONER_SPELLS, {spellListData: spell_list_data, locale: locale, version: version, dataById: data_by_id}
      end

      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getSummonerSpellById
      def static_summoner_spell(id:, spell_data: nil, locale: nil, version: nil)
        response_for STATIC_SUMMONER_SPELL, {id: id, spellData: spell_data, locale: locale, version: version}
      end

      # Returns [Array] of static data version numbers.
      #
      # @see https://developer.riotgames.com/api-methods/#static-data-v3/GET_getVersions
      # @return [Array] of version numbers
      # @example
      #   versions = client.static_versions
      def static_versions
        response_for STATIC_VERSIONS
      end
    end
  end
end
