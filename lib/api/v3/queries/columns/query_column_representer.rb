#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

module API
  module V3
    module Queries
      module Columns
        class QueryColumnRepresenter < ::API::Decorators::Single
          include API::Utilities::RepresenterToJsonCache

          self_link path: "query_column",
                    id_attribute: ->(*) { converted_name },
                    title_getter: ->(*) { represented.caption }

          def initialize(model, *_)
            super(model, current_user: nil, embed_links: true)
          end

          property :id,
                   exec_context: :decorator

          property :caption,
                   as: :name

          def converted_name
            convert_attribute(represented.name)
          end

          alias :id :converted_name

          def convert_attribute(attribute)
            ::API::Utilities::PropertyNameConverter.from_ar_name(attribute)
          end

          def json_cache_key
            [represented.name, represented.caption]
          end
        end
      end
    end
  end
end
