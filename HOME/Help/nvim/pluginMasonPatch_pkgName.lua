-- NEW:
    local pkg_aliases = pkg:get_aliases()
    if #pkg_aliases > 0 then
        package_line[#package_line + 1] = p.Comment(" " .. table.concat(pkg:get_aliases(), ", "))
    end

    -- Bepaal de padding om de keywords verticaal uit te lijnen
    local target_width = 40  -- Kolombreedte. Verhoog dit getal als de tekst nog niet overal past.
    local padding = target_width - #pkg.name
    if padding < 1 then padding = 1 end

    package_line[#package_line + 1] = p.Comment(string.rep(" ", padding) .. ("(keywords: %s)"):format(get_package_search_keywords(pkg)))

    if not opts.is_installed and pkg.spec.deprecation ~= nil then
        package_line[#package_line + 1] = p.warning " deprecated"
    end

-- OUD:
   134     local function PackageComponent(state, pkg, opts)
   135     local pkg_state = state.packages.states[pkg.name]
   136     local is_expanded = state.packages.expanded == pkg.name
   137     local label = (is_expanded or pkg_state.has_transitioned) and p.Bold(" " .. pkg.name) or p.none(" " .. pkg.name)
   138
   139     local package_line = {
   140         opts.icon,
   141         label,
   142     }
   143
   144     local pkg_aliases = pkg:get_aliases()
   145     if #pkg_aliases > 0 then
   146         package_line[#package_line + 1] = p.Comment(" " .. table.concat(pkg:get_aliases(), ", "))
   147     end
   148         package_line[#package_line + 1] = p.Comment((" (keywords: %s)"):format(get_package_search_keywords(pkg)))
   149     if not opts.is_installed and pkg.spec.deprecation ~= nil then
   150         package_line[#package_line + 1] = p.warning " deprecated"
   151     end
