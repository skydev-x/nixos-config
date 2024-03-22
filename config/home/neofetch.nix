{ pkgs, config, ... }:

{
    home.file.".config/neofetch/config.conf".text = ''
print_info () {
    # Lines without an '&' sign will be displayed in
    # the order they appear here.
    info title
    info underline

    info "OS" distro &
    info "Kernel" kernel &
    info "Uptime" uptime &
    info "Packages" packages &
    info "Shell" shell &
    info "Window Manager" wm &
    info "GTK Theme" theme &
    info "Icons" icons &
    info "CPU" cpu &
    info "GPU" gpu &
    info "Memory" memory &

    # Wait for the functions to complete
    wait

    info cols
}    '';
}

