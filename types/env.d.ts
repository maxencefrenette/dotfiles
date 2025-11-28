declare namespace NodeJS {
    interface ProcessEnv {
        HOME: string;
        DOTFILES_REPO: string;
    }
}

declare module 'bun' {
    interface Env extends NodeJS.ProcessEnv {}
}
