package com.poly.filter;

import jakarta.servlet.*;
import java.io.IOException;

public class Filter2 implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        System.out.println(request.getAttribute("hello"));
        chain.doFilter(request, response);
    }
}
